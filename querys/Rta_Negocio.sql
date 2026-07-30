--1. ¿Cuál es el ranking de los productos más vendidos de “Dataˮ sin financiación (en una única cuota) en el primer trimestre de 2026?

SELECT  product_name, 
        product_type, 
        product_vertical, 
        COUNT(o.order_id) as Cantidad_Vendida
FROM `Sales.sales_orders` o
INNER JOIN `Sales.products` pr on pr.product_id = o.product_id and pr.product_vertical = 'Data'
INNER JOIN `Sales.payment_plans` p on p.plan_id = o.plan_id and p.order_id = o.order_id AND installments = 1
WHERE o.date BETWEEN '2026-01-01' AND '2026-03-31'
GROUP BY 1,2,3
ORDER BY 4 DESC


--2. ¿Cuáles son los usuarios que han comprado más de un producto y qué productos son?
--Nota: Ordenar el listado por usuario y por fecha de compra.


WITH
 --Usuarios que compraron mas de 1 producto
 --El enunciado no aclara que sean productos distintos por lo tanto no agregue un distinct, en todo caso seria count(DISTINCT product_id) > 1
 users_m1 as (
  SELECT o.user_id as u_id, 
         count(product_id)
    FROM `Sales.sales_orders` o
    GROUP BY 1
    HAVING count(product_id)  > 1
 )


SELECT   o.user_id, 
         CONCAT(name, ' ', last_name) AS full_name, 
         date,
         product_name
FROM `Sales.sales_orders` o
LEFT JOIN `Sales.users` u on u.user_id = o.user_id
LEFT JOIN `Sales.products` pr on pr.product_id = o.product_id
INNER JOIN users_m1 u_t ON  u_id = o.user_id
ORDER BY 1,3


--3. ¿Cuál es el monto total de las ventas en dólares, por mes y país?
--Las ventas totales en USD = currency = 'USD' o total de ventas y convertir resto de moneda a USD?

SELECT  EXTRACT(YEAR FROM date) year,
        EXTRACT(MONTH FROM date) month_num ,
        FORMAT_DATE('%B', date) month, 
        u.country , 
        SUM(amount) amount
FROM `Sales.sales_orders` o
LEFT JOIN `Sales.users` u on u.user_id = o.user_id
WHERE currency = 'USD'
GROUP BY 1,2,3,4
ORDER BY 1 ,2, 4,5 DESC




--4. ¿Qué usuarios no compraron ningún producto?

SELECT  u.user_id, 
        CONCAT(name, ' ', last_name) AS full_name, 
        country
FROM  `Sales.users` u
LEFT JOIN `Sales.sales_orders` o on u.user_id = o.user_id
WHERE o.order_id IS NULL


--5. ¿Qué planes de pago tienen cobros pendientes?
--Nota: el día de la venta se cobra la primera cuota, a los 30 días la segunda, a los 60 días la tercera y así sucesivamente.


SELECT * FROM (
  SELECT 
      o.order_id, 
      amount, 
      date, 
      o.plan_id, 
      installments,
      DIV(DATE_DIFF(current_date(), date, day), 30) + 1 AS cuotas_cobradas,
      CASE 
        WHEN DIV(DATE_DIFF(current_date(), date, day), 30) + 1 >= installments THEN 'Cobro finalizado' 
        ELSE 'Cobros Pendientes' 
      END AS Flg
  FROM `Sales.sales_orders` o
  LEFT JOIN `Sales.payment_plans` p ON p.plan_id = o.plan_id AND p.order_id = o.order_id
  WHERE installments > 1
)
WHERE Flg = 'Cobros Pendientes'
ORDER BY order_id



--6. ¿Qué usuarios realizaron compras por un monto mayor que el promedio de ventas de febrero?
--Nota: tener en cuenta que no es correcto agregar distintos tipo de moneda.
--No aclara si el total de ventas por usuario es por Febrero tambien o no, yo lo filtre por febrero.

WITH
 Avg_ventas AS (
  SELECT currency,
   ROUND(AVG(amount),2) avg_amount
  FROM `Sales.sales_orders`
  WHERE date BETWEEN '2026-02-01' AND '2026-02-28'
  GROUP BY 1
 )

SELECT user_id, full_name, currency, avg_amount, Amount, flg
FROM (
  SELECT o.user_id, CONCAT(name, ' ', last_name) AS full_name, o.currency, av.avg_amount, 
         SUM(o.amount) Amount,
         CASE WHEN SUM(o.amount) > av.avg_amount THEN 'Supera el monto' ELSE 'No Supera' end as flg
  FROM `Sales.sales_orders` o
  LEFT JOIN `Sales.users` u on u.user_id = o.user_id
  LEFT JOIN Avg_ventas av on av.currency = o.currency
  WHERE o.date BETWEEN '2026-02-01' AND '2026-02-28'
  GROUP BY 1,2,3,4
)
WHERE flg = 'Supera el monto'
ORDER BY user_id

