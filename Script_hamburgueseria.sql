-- Queris 
	-- Ejercicio 1 
select * 
from hamburguesa h 
where valor_calorico between 350 and 500
order by valor_calorico 
limit 5;

	-- Ejercicio 2
select * from hamburguesa h 
join hamburgueseria h2 on h2.id = h.id_hamburgueseria ;

	-- Ejercicio 3
select h.nombre as hamburgueseria , count(distinct h2.id) as num_hamburguesas, sum(h2.valor_calorico) as calorias_totales  
from hamburgueseria h 
join hamburguesa h2 on h2.id_hamburgueseria = h.id 
group by h.id ;

	-- Ejercicio 4
select h.nombre as hamburguesa, i.nombre as ingrediente
from hamburguesa_ingredientes hi 
join hamburguesa h on h.id = hi.id_hamburguesa 
join ingrediente i on i.id = hi.id_ingrediente 
order by h.nombre ;

	-- Ejercicio 5
select h.nombre as hamburguesa, avg(vh.valoracion) as valoracion 
from valoracion_hamburguesa vh 
join hamburguesa h on h.id = vh.id_hamburguesa 
group by h.id ;

select avg(vh.valoracion) as valoracion  from valoracion_hamburguesa vh join hamburguesa h on h.id = vh.id_hamburguesa  where h.id_hamburgueseria = 1 group by h.id ;


-- Ejercicio 3
	-- 1

DELIMITER &&
create or replace function crear_valoracion_hamburguesa (v_id_hamburguesa int, v_cliente varchar(150), v_comentario varchar(150), v_valoracion int) returns int
begin 
	
	declare hamburguesa_existe int;
	declare valoracion_existe int;
	declare id_valoracion int;


	select count(id) into hamburguesa_existe from hamburguesa h where id = v_id_hamburguesa;
	select count(nombre_cliente) into valoracion_existe from valoracion_hamburguesa vh where nombre_cliente = v_cliente ;

	if valoracion_existe = 1 and hamburguesa_existe = 1 then 
		insert into valoracion_hamburguesa (id_hamburguesa, nombre_cliente, opinion, valoracion_hamburguesa)
		values (v_id_hamburguesa, v_cliente, v_comentario, v_valoracion);
		
	
		select id into id_valoracion
		from valoracion_hamburguesa vh 
		where id_hamburguesa = v_id_hamburguesa 
			and nombre_cliente = v_nombre_cliente 
			and opinion = v_opinion 
			and valoracion_hamburguesa = v_valoracion_hamburguesa 
		limit 1;
	
		return id_valoracion;
		
	else
		return 0;
	
	end if;
end;&&
DELIMITER

select crear_valoracion_hamburguesa (1,1,"Juan Gutierrez","Muy rica",9);

select * from valoracion_hamburguesa vh ;

select count(id)  
from hamburguesa h 
where id = 1;

select count(nombre_cliente) 
from valoracion_hamburguesa vh where nombre_cliente =  ;
