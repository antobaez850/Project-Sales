{\rtf1\ansi\ansicpg1252\cocoartf2822
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fnil\fcharset0 Menlo-Regular;}
{\colortbl;\red255\green255\blue255;\red167\green0\blue95;\red255\green255\blue255;\red24\green25\blue27;
\red22\green79\blue199;\red0\green0\blue0;\red46\green49\blue51;\red24\green112\blue43;\red159\green77\blue4;
}
{\*\expandedcolortbl;;\cssrgb\c72157\c2353\c44706;\cssrgb\c100000\c100000\c100000;\cssrgb\c12549\c12941\c14118;
\cssrgb\c9804\c40392\c82353;\cssrgb\c0\c0\c0;\cssrgb\c23529\c25098\c26275;\cssrgb\c9412\c50196\c21961;\cssrgb\c69020\c37647\c0;
}
\paperw11900\paperh16840\margl1440\margr1440\vieww21720\viewh13360\viewkind0
\deftab720
\pard\pardeftab720\partightenfactor0

\f0\fs24 \cf2 \cb3 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 --1. \'bfCu\'e1l es el ranking de los productos m\'e1s vendidos de \'93Data\uc0\u750  sin financiaci\'f3n (en una \'fanica cuota) en el primer trimestre de 2026?\cf4 \cb1 \strokec4 \
\
\pard\pardeftab720\partightenfactor0
\cf5 \cb3 \strokec5 SELECT\cf4 \strokec4   \strokec6 product_name\strokec4 , \cb1 \
\pard\pardeftab720\partightenfactor0
\cf4 \cb3         \strokec6 product_type\strokec4 , \cb1 \
\cb3         \strokec6 product_vertical\strokec4 , \cb1 \
\cb3         \cf5 \strokec5 COUNT\cf7 \strokec7 (\cf4 \strokec6 o.order_id\cf7 \strokec7 )\cf4 \strokec4  \cf5 \strokec5 as\cf4 \strokec4  \strokec6 Cantidad_Vendida\cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf5 \cb3 \strokec5 FROM\cf4 \strokec4  \strokec6 `Sales.sales_orders`\strokec4  \strokec6 o\cb1 \strokec4 \
\cf5 \cb3 \strokec5 INNER\cf4 \strokec4  \cf5 \strokec5 JOIN\cf4 \strokec4  \strokec6 `Sales.products`\strokec4  \strokec6 pr\strokec4  \cf5 \strokec5 on\cf4 \strokec4  \strokec6 pr.product_id\strokec4  = \strokec6 o.product_id\strokec4  \cf5 \strokec5 and\cf4 \strokec4  \strokec6 pr.product_vertical\strokec4  = \cf8 \strokec8 'Data'\cf4 \cb1 \strokec4 \
\cf5 \cb3 \strokec5 INNER\cf4 \strokec4  \cf5 \strokec5 JOIN\cf4 \strokec4  \strokec6 `Sales.payment_plans`\strokec4  \strokec6 p\strokec4  \cf5 \strokec5 on\cf4 \strokec4  \strokec6 p.plan_id\strokec4  = \strokec6 o.plan_id\strokec4  \cf5 \strokec5 and\cf4 \strokec4  \strokec6 p.order_id\strokec4  = \strokec6 o.order_id\strokec4  \cf5 \strokec5 AND\cf4 \strokec4  \strokec6 installments\strokec4  = \cf9 \strokec9 1\cf4 \cb1 \strokec4 \
\cf5 \cb3 \strokec5 WHERE\cf4 \strokec4  \strokec6 o.date\strokec4  \cf5 \strokec5 BETWEEN\cf4 \strokec4  \cf8 \strokec8 '2026-01-01'\cf4 \strokec4  \cf5 \strokec5 AND\cf4 \strokec4  \cf8 \strokec8 '2026-03-31'\cf4 \cb1 \strokec4 \
\cf5 \cb3 \strokec5 GROUP\cf4 \strokec4  \cf5 \strokec5 BY\cf4 \strokec4  \cf9 \strokec9 1\cf4 \strokec4 ,\cf9 \strokec9 2\cf4 \strokec4 ,\cf9 \strokec9 3\cf4 \cb1 \strokec4 \
\cf5 \cb3 \strokec5 ORDER\cf4 \strokec4  \cf5 \strokec5 BY\cf4 \strokec4  \cf9 \strokec9 4\cf4 \strokec4  \cf5 \strokec5 DESC\cf4 \cb1 \strokec4 \
\
\
\pard\pardeftab720\partightenfactor0
\cf2 \cb3 \strokec2 --2. \'bfCu\'e1les son los usuarios que han comprado m\'e1s de un producto y qu\'e9 productos son?\cf4 \cb1 \strokec4 \
\cf2 \cb3 \strokec2 --Nota: Ordenar el listado por usuario y por fecha de compra.\cf4 \cb1 \strokec4 \
\
\
\pard\pardeftab720\partightenfactor0
\cf5 \cb3 \strokec5 WITH\cf4 \cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf4 \cb3  \cf2 \strokec2 --Usuarios que compraron mas de 1 producto\cf4 \cb1 \strokec4 \
\cb3  \cf2 \strokec2 --El enunciado no aclara que sean productos distintos por lo tanto no agregue un distinct, en todo caso seria count(DISTINCT product_id) > 1\cf4 \cb1 \strokec4 \
\cb3  \strokec6 users_m1\strokec4  \cf5 \strokec5 as\cf4 \strokec4  \cf7 \strokec7 (\cf4 \cb1 \strokec4 \
\cb3   \cf5 \strokec5 SELECT\cf4 \strokec4  \strokec6 o.user_id\strokec4  \cf5 \strokec5 as\cf4 \strokec4  \strokec6 u_id\strokec4 , \cb1 \
\cb3          \cf5 \strokec5 count\cf7 \strokec7 (\cf4 \strokec6 product_id\cf7 \strokec7 )\cf4 \cb1 \strokec4 \
\cb3     \cf5 \strokec5 FROM\cf4 \strokec4  \strokec6 `Sales.sales_orders`\strokec4  \strokec6 o\cb1 \strokec4 \
\cb3     \cf5 \strokec5 GROUP\cf4 \strokec4  \cf5 \strokec5 BY\cf4 \strokec4  \cf9 \strokec9 1\cf4 \cb1 \strokec4 \
\cb3     \cf5 \strokec5 HAVING\cf4 \strokec4  \cf5 \strokec5 count\cf7 \strokec7 (\cf4 \strokec6 product_id\cf7 \strokec7 )\cf4 \strokec4   \cf7 \strokec7 >\cf4 \strokec4  \cf9 \strokec9 1\cf4 \cb1 \strokec4 \
\cb3  \cf7 \strokec7 )\cf4 \cb1 \strokec4 \
\
\
\pard\pardeftab720\partightenfactor0
\cf5 \cb3 \strokec5 SELECT\cf4 \strokec4    \strokec6 o.user_id\strokec4 , \cb1 \
\pard\pardeftab720\partightenfactor0
\cf4 \cb3          \cf5 \strokec5 CONCAT\cf7 \strokec7 (\cf4 \strokec6 name\strokec4 , \cf8 \strokec8 ' '\cf4 \strokec4 , \strokec6 last_name\cf7 \strokec7 )\cf4 \strokec4  \cf5 \strokec5 AS\cf4 \strokec4  \strokec6 full_name\strokec4 , \cb1 \
\cb3          \cf5 \strokec5 date\cf4 \strokec4 ,\cb1 \
\cb3          \strokec6 product_name\cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf5 \cb3 \strokec5 FROM\cf4 \strokec4  \strokec6 `Sales.sales_orders`\strokec4  \strokec6 o\cb1 \strokec4 \
\cf5 \cb3 \strokec5 LEFT\cf4 \strokec4  \cf5 \strokec5 JOIN\cf4 \strokec4  \strokec6 `Sales.users`\strokec4  \strokec6 u\strokec4  \cf5 \strokec5 on\cf4 \strokec4  \strokec6 u.user_id\strokec4  = \strokec6 o.user_id\cb1 \strokec4 \
\cf5 \cb3 \strokec5 LEFT\cf4 \strokec4  \cf5 \strokec5 JOIN\cf4 \strokec4  \strokec6 `Sales.products`\strokec4  \strokec6 pr\strokec4  \cf5 \strokec5 on\cf4 \strokec4  \strokec6 pr.product_id\strokec4  = \strokec6 o.product_id\cb1 \strokec4 \
\cf5 \cb3 \strokec5 INNER\cf4 \strokec4  \cf5 \strokec5 JOIN\cf4 \strokec4  \strokec6 users_m1\strokec4  \strokec6 u_t\strokec4  \cf5 \strokec5 ON\cf4 \strokec4   \strokec6 u_id\strokec4  = \strokec6 o.user_id\cb1 \strokec4 \
\cf5 \cb3 \strokec5 ORDER\cf4 \strokec4  \cf5 \strokec5 BY\cf4 \strokec4  \cf9 \strokec9 1\cf4 \strokec4 ,\cf9 \strokec9 3\cf4 \cb1 \strokec4 \
\
\
\pard\pardeftab720\partightenfactor0
\cf2 \cb3 \strokec2 --3. \'bfCu\'e1l es el monto total de las ventas en d\'f3lares, por mes y pa\'eds?\cf4 \cb1 \strokec4 \
\cf2 \cb3 \strokec2 --Las ventas totales en USD = currency = 'USD' o total de ventas y convertir resto de moneda a USD?\cf4 \cb1 \strokec4 \
\
\pard\pardeftab720\partightenfactor0
\cf5 \cb3 \strokec5 SELECT\cf4 \strokec4   \cf5 \strokec5 EXTRACT\cf7 \strokec7 (\cf4 \strokec6 YEAR\strokec4  \cf5 \strokec5 FROM\cf4 \strokec4  \cf5 \strokec5 date\cf7 \strokec7 )\cf4 \strokec4  \strokec6 year\strokec4 ,\cb1 \
\pard\pardeftab720\partightenfactor0
\cf4 \cb3         \cf5 \strokec5 EXTRACT\cf7 \strokec7 (\cf4 \strokec6 MONTH\strokec4  \cf5 \strokec5 FROM\cf4 \strokec4  \cf5 \strokec5 date\cf7 \strokec7 )\cf4 \strokec4  \strokec6 month_num\strokec4  ,\cb1 \
\cb3         \cf5 \strokec5 FORMAT_DATE\cf7 \strokec7 (\cf8 \strokec8 '%B'\cf4 \strokec4 , \cf5 \strokec5 date\cf7 \strokec7 )\cf4 \strokec4  \strokec6 month\strokec4 , \cb1 \
\cb3         \strokec6 u.country\strokec4  , \cb1 \
\cb3         \cf5 \strokec5 SUM\cf7 \strokec7 (\cf4 \strokec6 amount\cf7 \strokec7 )\cf4 \strokec4  \strokec6 amount\cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf5 \cb3 \strokec5 FROM\cf4 \strokec4  \strokec6 `Sales.sales_orders`\strokec4  \strokec6 o\cb1 \strokec4 \
\cf5 \cb3 \strokec5 LEFT\cf4 \strokec4  \cf5 \strokec5 JOIN\cf4 \strokec4  \strokec6 `Sales.users`\strokec4  \strokec6 u\strokec4  \cf5 \strokec5 on\cf4 \strokec4  \strokec6 u.user_id\strokec4  = \strokec6 o.user_id\cb1 \strokec4 \
\cf5 \cb3 \strokec5 WHERE\cf4 \strokec4  \strokec6 currency\strokec4  = \cf8 \strokec8 'USD'\cf4 \cb1 \strokec4 \
\cf5 \cb3 \strokec5 GROUP\cf4 \strokec4  \cf5 \strokec5 BY\cf4 \strokec4  \cf9 \strokec9 1\cf4 \strokec4 ,\cf9 \strokec9 2\cf4 \strokec4 ,\cf9 \strokec9 3\cf4 \strokec4 ,\cf9 \strokec9 4\cf4 \cb1 \strokec4 \
\cf5 \cb3 \strokec5 ORDER\cf4 \strokec4  \cf5 \strokec5 BY\cf4 \strokec4  \cf9 \strokec9 1\cf4 \strokec4  ,\cf9 \strokec9 2\cf4 \strokec4 , \cf9 \strokec9 4\cf4 \strokec4 ,\cf9 \strokec9 5\cf4 \strokec4  \cf5 \strokec5 DESC\cf4 \cb1 \strokec4 \
\
\
\
\
\pard\pardeftab720\partightenfactor0
\cf2 \cb3 \strokec2 --4. \'bfQu\'e9 usuarios no compraron ning\'fan producto?\cf4 \cb1 \strokec4 \
\
\pard\pardeftab720\partightenfactor0
\cf5 \cb3 \strokec5 SELECT\cf4 \strokec4   \strokec6 u.user_id\strokec4 , \cb1 \
\pard\pardeftab720\partightenfactor0
\cf4 \cb3         \cf5 \strokec5 CONCAT\cf7 \strokec7 (\cf4 \strokec6 name\strokec4 , \cf8 \strokec8 ' '\cf4 \strokec4 , \strokec6 last_name\cf7 \strokec7 )\cf4 \strokec4  \cf5 \strokec5 AS\cf4 \strokec4  \strokec6 full_name\strokec4 , \cb1 \
\cb3         \strokec6 country\cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf5 \cb3 \strokec5 FROM\cf4 \strokec4   \strokec6 `Sales.users`\strokec4  \strokec6 u\cb1 \strokec4 \
\cf5 \cb3 \strokec5 LEFT\cf4 \strokec4  \cf5 \strokec5 JOIN\cf4 \strokec4  \strokec6 `Sales.sales_orders`\strokec4  \strokec6 o\strokec4  \cf5 \strokec5 on\cf4 \strokec4  \strokec6 u.user_id\strokec4  = \strokec6 o.user_id\cb1 \strokec4 \
\cf5 \cb3 \strokec5 WHERE\cf4 \strokec4  \strokec6 o.order_id\strokec4  \cf5 \strokec5 IS\cf4 \strokec4  \cf5 \strokec5 NULL\cf4 \cb1 \strokec4 \
\
\
\pard\pardeftab720\partightenfactor0
\cf2 \cb3 \strokec2 --5. \'bfQu\'e9 planes de pago tienen cobros pendientes?\cf4 \cb1 \strokec4 \
\cf2 \cb3 \strokec2 --Nota: el d\'eda de la venta se cobra la primera cuota, a los 30 d\'edas la segunda, a los 60 d\'edas la tercera y as\'ed sucesivamente.\cf4 \cb1 \strokec4 \
\
\
\pard\pardeftab720\partightenfactor0
\cf5 \cb3 \strokec5 SELECT\cf4 \strokec4  \cf7 \strokec7 *\cf4 \strokec4  \cf5 \strokec5 FROM\cf4 \strokec4  \cf7 \strokec7 (\cf4 \cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf4 \cb3   \cf5 \strokec5 SELECT\cf4 \strokec4  \cb1 \
\cb3       \strokec6 o.order_id\strokec4 , \cb1 \
\cb3       \strokec6 amount\strokec4 , \cb1 \
\cb3       \cf5 \strokec5 date\cf4 \strokec4 , \cb1 \
\cb3       \strokec6 o.plan_id\strokec4 , \cb1 \
\cb3       \strokec6 installments\strokec4 ,\cb1 \
\cb3       \cf5 \strokec5 DIV\cf7 \strokec7 (\cf5 \strokec5 DATE_DIFF\cf7 \strokec7 (\cf5 \strokec5 current_date\cf7 \strokec7 ()\cf4 \strokec4 , \cf5 \strokec5 date\cf4 \strokec4 , \strokec6 day\cf7 \strokec7 )\cf4 \strokec4 , \cf9 \strokec9 30\cf7 \strokec7 )\cf4 \strokec4  \cf7 \strokec7 +\cf4 \strokec4  \cf9 \strokec9 1\cf4 \strokec4  \cf5 \strokec5 AS\cf4 \strokec4  \strokec6 cuotas_cobradas\strokec4 ,\cb1 \
\cb3       \cf5 \strokec5 CASE\cf4 \strokec4  \cb1 \
\cb3         \cf5 \strokec5 WHEN\cf4 \strokec4  \cf5 \strokec5 DIV\cf7 \strokec7 (\cf5 \strokec5 DATE_DIFF\cf7 \strokec7 (\cf5 \strokec5 current_date\cf7 \strokec7 ()\cf4 \strokec4 , \cf5 \strokec5 date\cf4 \strokec4 , \strokec6 day\cf7 \strokec7 )\cf4 \strokec4 , \cf9 \strokec9 30\cf7 \strokec7 )\cf4 \strokec4  \cf7 \strokec7 +\cf4 \strokec4  \cf9 \strokec9 1\cf4 \strokec4  \cf7 \strokec7 >=\cf4 \strokec4  \strokec6 installments\strokec4  \cf5 \strokec5 THEN\cf4 \strokec4  \cf8 \strokec8 'Cobro finalizado'\cf4 \strokec4  \cb1 \
\cb3         \cf5 \strokec5 ELSE\cf4 \strokec4  \cf8 \strokec8 'Cobros Pendientes'\cf4 \strokec4  \cb1 \
\cb3       \cf5 \strokec5 END\cf4 \strokec4  \cf5 \strokec5 AS\cf4 \strokec4  \strokec6 Flg\cb1 \strokec4 \
\cb3   \cf5 \strokec5 FROM\cf4 \strokec4  \strokec6 `Sales.sales_orders`\strokec4  \strokec6 o\cb1 \strokec4 \
\cb3   \cf5 \strokec5 LEFT\cf4 \strokec4  \cf5 \strokec5 JOIN\cf4 \strokec4  \strokec6 `Sales.payment_plans`\strokec4  \strokec6 p\strokec4  \cf5 \strokec5 ON\cf4 \strokec4  \strokec6 p.plan_id\strokec4  = \strokec6 o.plan_id\strokec4  \cf5 \strokec5 AND\cf4 \strokec4  \strokec6 p.order_id\strokec4  = \strokec6 o.order_id\cb1 \strokec4 \
\cb3   \cf5 \strokec5 WHERE\cf4 \strokec4  \strokec6 installments\strokec4  \cf7 \strokec7 >\cf4 \strokec4  \cf9 \strokec9 1\cf4 \cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf7 \cb3 \strokec7 )\cf4 \cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf5 \cb3 \strokec5 WHERE\cf4 \strokec4  \strokec6 Flg\strokec4  = \cf8 \strokec8 'Cobros Pendientes'\cf4 \cb1 \strokec4 \
\cf5 \cb3 \strokec5 ORDER\cf4 \strokec4  \cf5 \strokec5 BY\cf4 \strokec4  \strokec6 order_id\cb1 \strokec4 \
\
\
\
\pard\pardeftab720\partightenfactor0
\cf2 \cb3 \strokec2 --6. \'bfQu\'e9 usuarios realizaron compras por un monto mayor que el promedio de ventas de febrero?\cf4 \cb1 \strokec4 \
\cf2 \cb3 \strokec2 --Nota: tener en cuenta que no es correcto agregar distintos tipo de moneda.\cf4 \cb1 \strokec4 \
\cf2 \cb3 \strokec2 --No aclara si el total de ventas por usuario es por Febrero tambien o no, yo lo filtre por febrero.\cf4 \cb1 \strokec4 \
\
\pard\pardeftab720\partightenfactor0
\cf5 \cb3 \strokec5 WITH\cf4 \cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf4 \cb3  \strokec6 Avg_ventas\strokec4  \cf5 \strokec5 AS\cf4 \strokec4  \cf7 \strokec7 (\cf4 \cb1 \strokec4 \
\cb3   \cf5 \strokec5 SELECT\cf4 \strokec4  \strokec6 currency\strokec4 ,\cb1 \
\cb3    \cf5 \strokec5 ROUND\cf7 \strokec7 (\cf5 \strokec5 AVG\cf7 \strokec7 (\cf4 \strokec6 amount\cf7 \strokec7 )\cf4 \strokec4 ,\cf9 \strokec9 2\cf7 \strokec7 )\cf4 \strokec4  \strokec6 avg_amount\cb1 \strokec4 \
\cb3   \cf5 \strokec5 FROM\cf4 \strokec4  \strokec6 `Sales.sales_orders`\cb1 \strokec4 \
\cb3   \cf5 \strokec5 WHERE\cf4 \strokec4  \cf5 \strokec5 date\cf4 \strokec4  \cf5 \strokec5 BETWEEN\cf4 \strokec4  \cf8 \strokec8 '2026-02-01'\cf4 \strokec4  \cf5 \strokec5 AND\cf4 \strokec4  \cf8 \strokec8 '2026-02-28'\cf4 \cb1 \strokec4 \
\cb3   \cf5 \strokec5 GROUP\cf4 \strokec4  \cf5 \strokec5 BY\cf4 \strokec4  \cf9 \strokec9 1\cf4 \cb1 \strokec4 \
\cb3  \cf7 \strokec7 )\cf4 \cb1 \strokec4 \
\
\pard\pardeftab720\partightenfactor0
\cf5 \cb3 \strokec5 SELECT\cf4 \strokec4  \strokec6 user_id\strokec4 , \strokec6 full_name\strokec4 , \strokec6 currency\strokec4 , \strokec6 avg_amount\strokec4 , \strokec6 Amount\strokec4 , \strokec6 flg\cb1 \strokec4 \
\cf5 \cb3 \strokec5 FROM\cf4 \strokec4  \cf7 \strokec7 (\cf4 \cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf4 \cb3   \cf5 \strokec5 SELECT\cf4 \strokec4  \strokec6 o.user_id\strokec4 , \cf5 \strokec5 CONCAT\cf7 \strokec7 (\cf4 \strokec6 name\strokec4 , \cf8 \strokec8 ' '\cf4 \strokec4 , \strokec6 last_name\cf7 \strokec7 )\cf4 \strokec4  \cf5 \strokec5 AS\cf4 \strokec4  \strokec6 full_name\strokec4 , \strokec6 o.currency\strokec4 , \strokec6 av.avg_amount\strokec4 , \cb1 \
\cb3          \cf5 \strokec5 SUM\cf7 \strokec7 (\cf4 \strokec6 o.amount\cf7 \strokec7 )\cf4 \strokec4  \strokec6 Amount\strokec4 ,\cb1 \
\cb3          \cf5 \strokec5 CASE\cf4 \strokec4  \cf5 \strokec5 WHEN\cf4 \strokec4  \cf5 \strokec5 SUM\cf7 \strokec7 (\cf4 \strokec6 o.amount\cf7 \strokec7 )\cf4 \strokec4  \cf7 \strokec7 >\cf4 \strokec4  \strokec6 av.avg_amount\strokec4  \cf5 \strokec5 THEN\cf4 \strokec4  \cf8 \strokec8 'Supera el monto'\cf4 \strokec4  \cf5 \strokec5 ELSE\cf4 \strokec4  \cf8 \strokec8 'No Supera'\cf4 \strokec4  \cf5 \strokec5 end\cf4 \strokec4  \cf5 \strokec5 as\cf4 \strokec4  \strokec6 flg\cb1 \strokec4 \
\cb3   \cf5 \strokec5 FROM\cf4 \strokec4  \strokec6 `Sales.sales_orders`\strokec4  \strokec6 o\cb1 \strokec4 \
\cb3   \cf5 \strokec5 LEFT\cf4 \strokec4  \cf5 \strokec5 JOIN\cf4 \strokec4  \strokec6 `Sales.users`\strokec4  \strokec6 u\strokec4  \cf5 \strokec5 on\cf4 \strokec4  \strokec6 u.user_id\strokec4  = \strokec6 o.user_id\cb1 \strokec4 \
\cb3   \cf5 \strokec5 LEFT\cf4 \strokec4  \cf5 \strokec5 JOIN\cf4 \strokec4  \strokec6 Avg_ventas\strokec4  \strokec6 av\strokec4  \cf5 \strokec5 on\cf4 \strokec4  \strokec6 av.currency\strokec4  = \strokec6 o.currency\cb1 \strokec4 \
\cb3   \cf5 \strokec5 WHERE\cf4 \strokec4  \strokec6 o.date\strokec4  \cf5 \strokec5 BETWEEN\cf4 \strokec4  \cf8 \strokec8 '2026-02-01'\cf4 \strokec4  \cf5 \strokec5 AND\cf4 \strokec4  \cf8 \strokec8 '2026-02-28'\cf4 \cb1 \strokec4 \
\cb3   \cf5 \strokec5 GROUP\cf4 \strokec4  \cf5 \strokec5 BY\cf4 \strokec4  \cf9 \strokec9 1\cf4 \strokec4 ,\cf9 \strokec9 2\cf4 \strokec4 ,\cf9 \strokec9 3\cf4 \strokec4 ,\cf9 \strokec9 4\cf4 \cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf7 \cb3 \strokec7 )\cf4 \cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf5 \cb3 \strokec5 WHERE\cf4 \strokec4  \strokec6 flg\strokec4  = \cf8 \strokec8 'Supera el monto'\cf4 \cb1 \strokec4 \
\cf5 \cb3 \strokec5 ORDER\cf4 \strokec4  \cf5 \strokec5 BY\cf4 \strokec4  \strokec6 user_id\cb1 \strokec4 \
\
\
}