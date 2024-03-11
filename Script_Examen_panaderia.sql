-- Ejercicio 1
	-- 1
select p.nombre, p.direccion, p.fecha_fundacion, timestampdiff(year, p.fecha_fundacion, current_date()) as anyos_funcionando
from panaderia p 
where p.nombre like "%pan%"
order by p.fecha_fundacion 
limit 3;

	-- 2
select p.nombre, count(t.id) 
from panaderia p 
join trabajador t on p.id = t.id_panaderia 
group by p.id;

	-- 3
select p.nombre, count(tp.id) as numero_tipos, sum(tp.precio_unidad) as suma_precio_unidad  
from tipo_pan tp
join tipo_pan_panaderia tpp on tpp.id_tipo_pan = tp.id 
join panaderia p on p.id = tpp.id_panaderia 
group by p.id ;

	-- 4
select p.nombre, avg(timestampdiff(year, c2.fecha_nacimiento, current_date())) as media_edad_cliente
from panaderia p 
join compra c on c.id_panaderia = p.id 
join cliente c2 on c2.id = c.id_cliente 
group by p.id ;

	-- 5
select *
from linea_compra lc 
join compra c on c.id = lc.id_compra 
where timestampdiff(day, c.fecha_compra, current_date()) > 0 ;


	-- 6
select c.nombre as cliente, p.nombre as panaderia
from cliente c 
join compra c2 on c2.id_cliente = c.id 
join panaderia p on p.id = c2.id_panaderia 
where p.id = (
	select c2sub.id_panaderia  
	from cliente csub 
	join compra c2sub on c2sub.id_cliente = csub.id 
	where csub.id = p.id 
	group by c2sub.id_panaderia  
	order by count(c2sub.id_panaderia) desc
	limit 1
)
group by c.id ;

	-- 7
select c.codigo, c2.nombre as cliente, p.nombre as panaderia , if (lc.unidades = tp.unidades_oferta, lc.unidades * tp.unidades_oferta, lc.unidades * tp.precio_unidad ) as importe_total
from linea_compra lc 
join compra c on c.id = lc.id_compra 
join tipo_pan tp on tp.id = lc.id_tipo_pan
join cliente c2 on c2.id = c.id_cliente 
join panaderia p on p.id = c.id_panaderia ;


-- Ejercicio 2
	-- 1
DELIMITER &&
create or replace procedure asociar_tipo_pan_panaderia (v_id_tipo_pan int, v_id_panaderia int)
begin 
	
	declare panaderia_existe int;
	declare tipo_pan_existe int;
	declare tipo_pan_panaderia_existe int;
	
	select count(p.id) into panaderia_existe from panaderia p where p.id = v_id_panaderia;
	select count(tp.id) into tipo_pan_existe from tipo_pan tp where tp.id = v_id_tipo_pan;
	select count(tpp.id_tipo_pan) into tipo_pan_panaderia_existe from tipo_pan_panaderia tpp where tpp.id_tipo_pan = v_id_tipo_pan and tpp.id_panaderia = v_id_panaderia;

	if panaderia_existe = 1 and tipo_pan_existe = 1 and tipo_pan_panaderia_existe = 0 then 
		
		insert into tipo_pan_panaderia (id_tipo_pan, id_panaderia)
		values (v_id_tipo_pan, v_id_panaderia);
	
	end if;
	
end;&&
DELIMITER

	-- 2
DELIMITER &&
create or replace procedure elimina_compras_incorrectas ()
begin 
	
	declare v_id_compra int;
	declare v_fecha_compra datetime;
	declare linea_compra_existe int;
	declare done int default 0;
	-- Cursor para manejar los resultados
	declare mi_cursor cursor for select c.id from compra c ;
	-- Manejar casos donde no hay más resultados
	declare continue handler for not found set done = 1;
	

	-- abrir cursor
	open mi_cursor;
	
	-- bucle loop para recorrer los resultados
	mi_loop: loop
		
			-- leer datos del cursor
			fetch mi_cursor into v_id_compra;
			
			select count(lc.id_compra) into linea_compra_existe from linea_compra lc where lc.id_compra = v_id_compra;
			select c.fecha_compra into v_fecha_compra from compra c where c.id = v_id_compra;
			
			if timestampdiff(day, v_fecha_compra, current_date()) < 0 or linea_compra_existe = 0 then
				
				update linea_compra 
					set id_compra = null
				where id_compra = v_id_compra;
			
				update linea_compra 
					set id_tipo_pan = null
				where id_compra = v_id_compra;
				
				update linea_compra 
					set unidades = null
				where id_compra = v_id_compra;
				
			end if;
		
	end loop mi_loop;	
	
end;&&
DELIMITER

	-- 3
DELIMITER &&
create or replace procedure crear_linea_compra (v_id_compra int, v_id_tipo_pan int, v_unidades int)
begin 
	
	declare existe_compra int;
	declare existe_tipo_pan int;
	declare linea_compra_existe int;

	select count(c.id) into existe_compra from compra c where c.id = v_id_compra;
	select count(tp.id) into existe_tipo_pan from tipo_pan tp where tp.id = v_id_tipo_pan;
	select count(lc.id_compra) into linea_compra_existe from linea_compra lc where lc.id_compra = v_id_compra and lc.id_tipo_pan = v_id_tipo_pan;

	if existe_compra = 1 and existe_tipo_pan = 1 and linea_compra_existe = 1 then
		
		update linea_compra 
			set unidades = unidades + v_unidades
		where id_compra = v_id_compra and id_tipo_pan = v_id_tipo_pan;
		
	else
			
		insert into linea_compra (id_compra, id_tipo_pan, unidades)
		values (v_id_compra, v_id_tipo_pan, v_unidades);
		
	end if;
	
end;&&
DELIMITER
