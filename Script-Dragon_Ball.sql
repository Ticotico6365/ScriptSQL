-- Ejercicico 1
select p.nombre , p.raza , p.poder_base, COALESCE(p2.nombre, 'desconocido') as nom_planeta
from personaje p 
left join planeta p2 on p2.id = p.id_planeta ;

-- Ejercicio 2
select p.raza ,sum(p.poder_base) as sumatorio_poder, sum(energia) as sumatorio_energia 
from personaje p 
group by raza ;

-- Ejercicio 3
select es_villano ,count(id) 
from personaje p 
group by es_villano ;

-- Ejericio 4
select p.nombre ,tc.nombre_tecnica ,tc.descripcion ,tc.requisito_energia 
from personaje p 
join tecnicas_combate tc on tc.id_personaje = p.id ;

-- Ejercico 5
select p.nombre ,p.poder_base ,COALESCE(SUM(tc.requisito_energia), 0),COALESCE(SUM(t.requisito_energia), 0), p.poder_base - (COALESCE(SUM(tc.requisito_energia), 0) - COALESCE(SUM(t.requisito_energia), 0))-- sum(tc.requisito_energia ), sum(t.requisito_energia), p.poder_base-(sum(tc.requisito_energia )-sum(t.requisito_energia))
from personaje p 
left join tecnicas_combate tc on tc.id_personaje = p.id 
left join personaje_tranformacion pt on pt.id_personaje = p.id
left join transformacion t on t.id = pt.id_tranformacion 
group by p.id ;

-- Ejercicio 6
select p.nombre, count(distinct t.id) as num_transformaciones, count(distinct tc.id) as num_tecnicas
from personaje p 
left join tecnicas_combate tc on tc.id_personaje = p.id 
left join personaje_tranformacion pt on pt.id_personaje = p.id
left join transformacion t on t.id = pt.id_tranformacion 
group by p.id ;

-- Ejercicico 7
select p.nombre, p.poder_base  , t.nombre, t.descripcion, t.poder_transformacion
from personaje p 
join personaje_tranformacion pt on pt.id_personaje = p.id 
join transformacion t on t.id = pt.id_tranformacion 
where t.id  = (
		select t2.id  
		from personaje_tranformacion pt2 
		join transformacion t2 on t2.id = pt2.id_tranformacion 
		where pt2.id_personaje = p.id
		order by t2.poder_transformacion desc 
		limit 1
			)
group by p.id ;

-- Ejercicio 8
select nombre_saga,sec_to_time(timestampdiff(day, fecha_inicio_saga , fecha_fin_saga) * 10800) as dura_en_sec_por_dias
from saga s;

-- Ejercicio 9
select p.nombre , s.nombre_saga , ps.num_capitulos 
from personaje p 
join personaje_saga ps on ps.id_personaje = p.id 
join saga s on s.id = ps.id_saga 
where s.id = (
		select ps2.id_saga 
		from personaje_saga ps2
		where ps2.id_personaje = p.id 
		order by ps2.num_capitulos desc 
		limit 1
		)
group by p.id ;

-- Ejericio 10
select *
from personaje p 
join personaje_saga ps on ps.id_personaje = p.id 
join saga s on s.id = ps.id_saga 
where timestampdiff(day, s.fecha_inicio_saga , s.fecha_fin_saga)*2 < ps.num_capitulos;

select *
from planeta p; 
select *
from personaje p ;
select *
from tecnicas_combate tc ;
select *
from transformacion t ;








-- funciones

DELIMITER $$
create procedure rellenarPlaneta(personaje_id int)
begin
	
	declare personaje_existe int;
	declare tiene_planeta int;
	declare pepe int;

	
	select count(id) into personaje_existe from personaje where id= personaje_id;


	if personaje_existe = 1 then 
		
		select id_planeta into tiene_planeta from personaje where id = personaje_id;
	
		if tiene_planeta is null then
			
			select id into pepe from planeta  limit 1;
		
			update personaje set id_planeta  = pepe where id= personaje_id;

end; $$
DELIMITER
		
DELIMITER $$
create function calcularPoderPorRaza( parametro varchar(100)) returns int
begin 
	
	-- Integer total = 0;
	-- total = 0
	declare total int default 0;

	-- total = sum(poder_personaje);
	select sum(poder_base) into total from personaje where raza = parametro;

	
	-- return total;
	return total;
	
	
end; $$
DELIMITER

select id from tecnicas_combate tc where id_personaje = 1 ;

delimiter &&
create or replace procedure crea_tecnica (v_nombre varchar (100), v_descripcion varchar(250), v_requisito_energia int, v_personaje_id int)
begin
	
	declare existe_personaje int;
	declare tecnica_combate_repetida int;

	select count(id) into existe_personaje from personaje p  where id = v_personaje_id ;
	select count(id) into tecnica_combate_repetida from tecnicas_combate tc where nombre_tecnica = v_nombre;



	if existe_personaje = 1 and tecnica_combate_repetida = 0 then
	
		insert into tecnicas_combate (nombre_tecnica, descripcion, requisito_energia, id_personaje)
		values(v_nombre, v_descripcion, v_requisito_energia, v_personaje_id);
	
	signal sqlstate '01000' set menssage_text = "Se ha insertado una nueva técnica";
		
	end if;
		
end &&
delimiter

call crea_tecnica("bofjs", "kjbsf", 150, 15);

select * from tecnicas_combate tc ;

