-- Preguntas

-- Ejercicio1
select *
from cadena_supermercado
where year(current_date()) - anyo_fundacion < 50 and  num_supermercados_totales >= 6000
limit 3;

-- Eejercicio2 
select ss.nombre
from seccion_supermercado ss 
where tipo_productos = "Alimentación";

-- Ejercicio 3
select pais_origen, count(id) as num_supermercados, sum(num_supermercados_totales) as supermercados_por_marca
from cadena_supermercado 
group by pais_origen;

-- Ejercicio4
select (select c.nombre from cliente c where c.id = rc.id_cliente) as cliente, count(rc.id_producto) as num_compras
from registro_compra rc
where rc.fecha_compra >= current_date()
group by rc.id_cliente;

-- Ejercicio 5
select
    (select cs.nombre 
	    from cadena_supermercado cs 
	    where cs.id = p.id_cadena_supermercado) as nombre_supermercado,
    (select ss.tipo_productos 
	    from seccion_supermercado ss 
	    where ss.id = p.id_seccion) as tipo_producto,
    (select avg(p2.precio) 
    	from producto p2 
	    where p2.id_seccion = p.id_seccion and p2.id_cadena_supermercado = p.id_cadena_supermercado 
	    group by p2.id_cadena_supermercado) as media_supermercado,
    avg(p.precio) as media_seccion
from producto p
group by p.id_seccion;


-- Ejercicio 6 Me lo he inventado, esto mira el número de clientes de cada cadena de supermercado
select cs.nombre,
cs.pais_origen,
coalesce ((select count(c3.id) 
			from cliente c3 
			where c3.pais = cs.pais_origen 
			group by pais), 
			(select count(c3.id) 
			from cliente c3 
			where c3.pais = "usa" 
			group by pais) ) as numero_cientes
from cadena_supermercado cs 
group by cs.id;

-- Ejercicio 7
select cs.nombre, sum(rc.unidades) * p.precio as facturacion_total
from cadena_supermercado cs 
join producto p on p.id_cadena_supermercado = cs.id 
join registro_compra rc on rc.id_producto = p.id 
group by cs.id ;

-- Ejercicio 8
select p.nombre, cs.nombre
from producto p 
left join proveedores_productos pp on pp.id_producto = p.id 
left join proveedores p2 on p2.id = pp.id_proveedor
join cadena_supermercado cs on cs.id = p.id_cadena_supermercado  
where p2.id is null;



-- Funciones

-- Ejercicio 1 
DELIMITER &&
create or replace procedure asociar_proveedor(v_id_proveedor int, v_id_producto int)
begin 
	declare existe_proveedor int;
	declare existe_producto int;
	declare existe_relacion_proveedor_producto int;

	select count(p.id) into existe_proveedor from proveedores p where p.id = v_id_proveedor;
	select count(p2.id) into existe_producto from producto p2 where p2.id = v_id_producto; 
	select count(pp.id_proveedor) into existe_relacion_proveedor_producto from proveedores_productos pp where pp.id_proveedor = v_id_proveedor and pp.id_producto = v_id_producto;
	
	if existe_proveedor = 1 and existe_producto = 1 and existe_relacion_proveedor_producto = 0 then 
	
		insert into proveedores_productos (id_proveedor, id_producto)
		values (v_id_proveedor, v_id_producto);
		
	end if;
	
end; &&
DELIMITER
call asociar_proveedor(2, 12);
select *
from proveedores_productos pp ;

select *
from producto p ;


-- Ejercicio 2
/*DELIMITER &&
create or replace procedure fechas_registros_compras ()
begin 
	declare v_fecha_compra date;
	declare fecha_hoy date;

	select current_date() into fecha_hoy;
	select fecha_compra into v_fecha_compra from registro_compra rc order by fecha_compra limit 1;
	
	while v_fecha_compra != fecha_hoy 
		
	
	
end; &&
DELIMITER*/


-- Ejercicio 3 
DELIMITER &&
create or replace function registra_producto (v_id_producto int, v_nombre varchar(100), v_marca varchar(100), v_descripción varchar(1000), v_precio decimal(10, 2), v_id_seccion int, v_id_supermercado int)
begin 
	declare existe_producto int;
	declare existe_seccion int;
	declare existe_supermercado int;
	declare repite_nombre_marca_descripcion int;
	
	select count(p2.id) into existe_producto from producto p2 where p2.id = v_id_producto;
	select count(ss.id) into existe_seccion from seccion_supermercado ss where ss.id = v_id_seccion;
	select count(cs.id) into existe_supermercado from cadena_supermercado cs where cs.id = v_id_supermercado;
	select count(p.id) into repite_nombre_marca_descripcion from producto p where p.nombre = v_nombre and p.marca = v_marca and p.descripcion = v_descripcion;


	if existe_producto = 1 and existe_seccion = 1 and existe_supermercado = 1 then 
	
		if repite_nombre_marca_descripcion = 1 then
			select "El producto con dichos datos ya existe" as mensaje;
		else
			insert into producto (id, nombre, marca, descripcion, precio, id_seccion, id_cadena_supermercado)
			values (v_id_producto, v_nombre, v_marca, v_descripción, v_precio, v_id_seccion, v_id_supermercado);
		
			select "Se ha creado el producto nuevo" as mensaje;
		end if;
	
	else
		select "Los datos introducidos son incorrectos" as mensaje;
	
	end if;
	
end; &&
DELIMITER

select * from seccion_supermercado ss ;
select * from cadena_supermercado cs ;
select * from producto p ;


select fecha_compra 
from registro_compra rc  
order by fecha_compra ;


select *
from proveedores_productos pp ;

select *
from proveedores p ;


select *
from proveedores_productos pp ;



select count(id) 
from cliente c 
group by pais 
where id = 1;

select *
from seccion_supermercado ss ;


select avg(precio)
from producto p 
group by id_cadena_supermercado
;


select nombre
from cadena_supermercado cs 
where id = 1;

select current_date(); 

select nombre
from cliente 
where id = 1;


select * 
from registro_compra;
grouping by id_cliente;
select *
from registro_compra;
select *
from cliente ;
select *
from seccion_supermercado ;
select *
from cadena_supermercado ;
