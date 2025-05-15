select * from menu_items;
--Realizar consultas para contestar las siguientes preguntas:
-- ● Encontrar el número de artículos en el menú.
 select count(distinct menu_item_id) articulos_totales
 from menu_items;
-- ● ¿Cuál es el artículo menos caro y el más caro en el menú?
select min (price) as baratoo,
max (price) as caroo
from menu_items;
-- ● ¿Cuántos platos americanos hay en el menú?
select count(category) platos_americanos
from menu_items
where category = 'American';
-- ● ¿Cuálesel precio promedio de los platos?
select round(avg(price),2) precio_promedio
from menu_items;
-------------------------------------------------------------
select * from order_details;

-- 1.- Realizar consultas para contestar las siguientes preguntas:
-- ● ¿Cuántos pedidos únicos se realizaron en total?
select count(distinct order_id) pedidos_totales
 from order_details;
-- ● ¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos?

select *
from (select order_id as Pedido, count(*) as veces
from order_details
group by order_id 
) as todo
order by veces desc
limit 5;

--● ¿Cuándo se realizó el primer pedido y el último pedido?
select min(order_time) hora_primera_orden,min(order_date) primer_dia_orden,
max(order_time) hora_ultima_ordern, max(order_date) ultimo_dia_orden
from order_details;
-- ● ¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?
select count(order_id) pedidos_totales
from order_details
where order_date between '2023-01-01' and '2023-01-05';
---------------------------------------
/* d) Usar ambas tablas para conocer la reacción de los clientes respecto al menú.

 1.- Realizar un left join entre entre order_details y menu_items con el identificador
 item_id(tabla order_details) y menu_item_id(tabla menu_items).*/

select * from order_details;
select * from menu_items;

select o.item_id, m.menu_item_id
from order_details o
left join menu_items m
 on o.item_id=m.menu_item_id
 where o.item_id is not null;
 
/* e) Una vez que hayas explorado los datos en las tablas correspondientes y respondido las
 preguntas planteadas, realiza un análisis adicional utilizando este join entre las tablas. El
 objetivo es identificar 5 puntos clave que puedan ser de utilidad para los dueños del
 restaurante en el lanzamiento de su nuevo menú. Para ello, crea tus propias consultas y
 utiliza los resultados obtenidos para llegar a estas conclusiones.*/
select * from order_details;
select * from menu_items;
 --Los 10 productos mas vendidos junto la categoria mas vendida y precio por unidad
select  count(o.item_id) Vendidos, m.item_name "Producto mas vendido",m.price Precio,m.category Categoria
from order_details o
left join menu_items m
on o.item_id=m.menu_item_id
group by 2,3,4
order by 1 desc
limit 10;
----------------------------------------------------------------------------------
--Los 30 dias con mas ventas y la categoria mas vendida del dia
select *
from (select o.order_date Dia, count(*) as Ventas,m.category "producto vendido"
from order_details o
left join menu_items m
on o.item_id=m.menu_item_id
group by 1,3 
having m.category is not null
) as o
order by 2 desc
limit 30;
---------------------------------------------------------------------------------