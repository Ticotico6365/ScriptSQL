-- Ejercicio 1
	-- 1
select a.descripcion as articulo , t.descripcion as talla
from talla t
join articulo_ropa ar on ar.id_talla = t.id 
join articulo a on a.id = ar.id_articulo 
where t.descripcion= "L" or t.descripcion = "M"
order by a.descripcion ;

	-- 2
select a.descripcion as artículo , tt.descripcion as talla
from tipo t 
join articulo_ropa ar on ar.id_tipo = t.id 
join articulo a on a.id = ar.id_articulo 
join talla tt on tt.id = ar.id_talla
where t.descripcion = 'Hombre';

	-- 3
select a.descripcion , t.descripcion , t2.descripcion 
from articulo_ropa ar  
join talla t on t.id = ar.id_talla
join tipo t2 on t2.id = ar.id_tipo 
join articulo a on a.id = ar.id_articulo 
where a.descripcion like "%Camiseta%";

	-- 4
select a.*, t.*
from articulo_ropa ar
join talla t on t.id = ar.id_talla
join articulo a on a.id = ar.id_articulo
where t.ancho_cuello between 3.7 and 8
	and t.ancho_torso between 5.2 and 8.7
	and t.ancho_cintura between 5.9 and 10
	and t.largo_manga between 5 and 11;

	-- 5
select *
from articulo_ropa ar 
join tipo t on t.id = ar.id_tipo
where t.id = 1 or t.id = 2;

	-- 6
select a.descripcion , sum(sa.precio) -- este esta mal
from stock_articulo sa 
join articulo_ropa ar on ar.id = sa.id_articulo_ropa 
join tipo t on t.id = ar.id_tipo 
join talla t2 on t2.id = ar.id_talla 
join articulo a on a.id = ar.id_articulo
group by t2.descripcion  
having sum(sa.precio) > 200;

-- ejercicio 2
	-- 7
select a.descripcion, ar.precio_base , t.ciudad, sa.id_tienda , sa.precio  
from articulo_ropa ar 
join articulo a on a.id = ar.id_articulo 
join stock_articulo sa on sa.id_articulo_ropa = ar.id 
join tienda t on t.id = sa.id_tienda 
where ar.id in (select sa.id_articulo_ropa  from stock_articulo sa );

	-- 8
select a.descripcion, t.descripcion as talla, sa.precio as precio_tienda, ar.precio_base, sa.precio - ar.precio_base as diferencia , ((sa.precio - ar.precio_base) * 100 )/ar.precio_base  as porcentaje_diferencia 
from articulo_ropa ar 
join stock_articulo sa on sa.id_articulo_ropa = ar.id 
join articulo a on a.id = ar.id_articulo 
join talla t on t.id = ar.id_talla ;

	-- 9
select a2.descripcion as nombre_articulo , t.descripcion as talla , sa.precio  -- mal
from marca_ropa mr 
join articulo_ropa ar on ar.id_marca = mr.id 
join articulo a on a.id = ar.id_articulo 
join stock_articulo sa on sa.id_articulo_ropa = ar.id 
join articulo a2 on a2.id = ar.id_articulo 
join talla t on t.id = ar.id_talla 
where mr.descripcion = 'ALVARO MORENO' ;

	-- 10
select *
from articulo_ropa ar 
join articulo a on a.id = ar.id_articulo 
join tipo t on t.id = ar.id_tipo 
join stock_articulo sa on sa.id_articulo_ropa  = ar.id 
where t.descripcion = "Juvenil" 
	or t.descripcion = "Infantil" 
	or t.descripcion = "Adolescente" 
	or t.descripcion = "Moda joven"
;


select *
from stock_articulo sa ;
select *
from talla t;
select *
from articulo_ropa a;
select *
from articulo a;
select *
from tipo t ;




-- Funciones

	-- Ejericio 1

DELIMITER $$
create or replace procedure `crear_cliente` (in nombre varchar(50), in apellidos varchar(50), in dni varchar(10))
begin
    declare codigo_cliente varchar(50);
    declare existe_cliente-pedido int;
    
    select concat("CC", auto_increment) into codigo_cliente from information_schema.tables where table_name = 'cliente' and table_schema = 'tienda_ropa';
    
    insert into cliente (nombre, apellidos, dni, codigo_cliente) 
    values (nombre, apellidos, dni, codigo_cliente);
    
end; $$
DELIMITER

call crear_cliente ("pedro", "Martínez", "12345678B");
select * from cliente c ;
alter table cliente auto_increment=0;


	-- Ejercicio 2
DELIMITER $$
create or replace procedure anyadir_articulo_pedido (v_id_cliente int, v_id_tienda int, v_id_articulo_ropa int, v_id_pedido int)
begin 
	declare cliente_existe int;
	declare tienda_existe int;
	declare tiene_stock int default 0;
	declare id_pedido_existe int;
	declare v_id_stock_articulo int;
	declare v_identificador int; 

	-- comprobamos es stock
	select count(sa.cantidad) into tiene_stock from stock_articulo sa where sa.id_articulo_ropa =  v_id_articulo_ropa;
	-- comprobamos el cliente
	select count(c.id) into cliente_existe from cliente c where c.id = v_id_cliente;
	-- comprobamos pedido
	select count(p.id) into id_pedido_existe from pedido p where p.id = v_id_pedido;
	-- vemos a que tienda y prenda le corresponde cada id_stock
	select sa.id into v_id_stock_articulo from stock_articulo sa where sa.id_tienda = v_id_tienda and sa.id_articulo_ropa = v_id_articulo_ropa limit 1;
	-- determinamos el identificador de la compra
	select auto_increment into v_identificador from information_schema.tables where table_name = "pedido" and table_schema = "tienda_ropa"; 

	if cliente_existe = 1 and tienda_existe = 1 and tiene_stock > 0 and id_pedido_existe = 1 then 
		
		insert into pedido_detalle (id_pedido, id_stock_articulo)
		values (v_id_pedido, v_id_stock_articulo);
	
		update stock_articulo  
		    set cantidad = cantidad -1 
		    where id_tienda = v_id_tienda and id_articulo_ropa = v_id_articulo_ropa;  
	
	else
	
		insert into pedido (identificador, id_cliente, id_tienda)
		values (v_identificador, v_id_cliente, v_id_tienda);
		
	end if;

	
end; $$
DELIMITER

call anyadir_articulo_pedido (3,1,1,4);



select count(sa.cantidad) from stock_articulo sa where sa.id_articulo_ropa = 1 ;
select count(c.id) from cliente c where c.id = 3;

insert into pedido (id, identificador, id_cliente)
values(1, "458da", 4);

select count(p.id) from pedido p where p.id = 1 ;

select * from pedido_detalle pd ;

select * from stock_articulo sa ;

select sa.id from stock_articulo sa where id_tienda = 1 and id_articulo_ropa = 3 limit 1;

update stock_articulo  
    set cantidad = cantidad -1 
    where id_tienda = 1 and id_articulo_ropa = 3;  
   
  update stock_articulo  
    set cantidad = cantidad +1 
    where id_tienda = 1 and id_articulo_ropa = 3;  
   
   alter table pedido 
   add id_tienda int(10);
  
  select * from pedido p ;

select auto_increment from information_schema.tables where table_name = "pedido" and table_schema = "tienda_ropa"; 

 
 
select *
from information_schema.tables;

select *
from cliente c ;

select auto_increment 
from information_schema.tables
where table_name = "cliente"
	and table_schema = 'tienda_ropa' ; 





