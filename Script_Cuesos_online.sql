-- Consultas

-- Ejercicio 1
select count(id) as num_cursos 
from curso_online co ;

-- Ejercicio 2
select sum(num_horas_totales) as horas_totales 
from curso_online co ;

-- Ejercicio 3
select
	(
	select co.nombre
	from curso_online co
	where co.id = i.id_curso) as nom_curso,
	count(i.id_usuario)
from inscripcion i
group by i.id_curso ;

-- Ejercicio 4
select co.nombre, count(s.id) as num_sesiones 
from curso_online co 
join sesion s on s.id_curso = co.id 
group by co.id ;

-- Ejercicio 5
select co.nombre, avg(year(current_date()) - year(u.fecha_nacimiento)) as media_edad
from curso_online co 
join inscripcion i on i.id_curso = co.id 
join usuario u on u.id = i.id_usuario 
group by co.id ;

-- Ejercicio 6
select co.nombre,  
	(
	select s.temario
	from sesion s
	where s.id_curso = co.id 
	order by num_horas_sesion desc
	limit 1 ) as sesion_mas_h,
		(
	select s.num_horas_sesion
	from sesion s
	where s.id_curso = co.id 
	order by num_horas_sesion desc
	limit 1 ) as horas
from curso_online co ;

-- Ejercicio 7
select co.nombre, count(i.id_usuario) as num_inscritos, sum(i.precio) as recaudacion
from curso_online co 
join inscripcion i on i.id_curso = co.id 
group by i.id_curso ;

-- Ejercicio 8
select u.nombre as nom_usuario, co.nombre as nom_curso, co.num_horas_totales as horas_curso,
	(
	select sum(s.num_horas_sesion)  
	from usuario_sesion us 
	join sesion s on s.id = us.id_sesion 
	where us.id_usuario = u.id 
	group by us.id_usuario) as num_horas_cursadas
from usuario u 
join inscripcion i on i.id_usuario = u.id 
join curso_online co on co.id = i.id_curso;


-- Funciones

-- Ejercicio 1
DELIMITER @@
create or replace procedure inscribir_usuario_curso(v_id_usuario int, v_id_curso int)
begin 
	
	declare existe_curso int;
	declare existe_usuario int;
	declare existe_inscripcion int;

	select count(*) into existe_curso from curso_online co where co.id = v_id_curso;
	select count(*) into existe_usuario from usuario u where u.id = v_id_usuario;
	select count(*) into existe_inscripcion from inscripcion i where i.id_usuario = v_id_usuario and i.id_curso = v_id_curso;

	if existe_curso = 1 and existe_usuario = 1 and existe_inscripcion = 0 
	then 
	
		insert into inscripcion (id_usuario, id_curso, fecha_inscripcion, precio)
		values (v_id_usuario, v_id_curso, current_date(), 3.40);

	end if;
	
end;@@
DELIMITER

-- Ejercicio 2
DELIMITER €€
create or replace procedure corregir_duracion_curso(v_id_curso int)
begin 
	
	declare existe_curso int;
	declare existe_sesion int;
	declare horas_sesion int;
	declare horas_curso int;

	select count(*) into existe_curso from curso_online co where co.id = v_id_curso;
	select count(distinct s.id_curso) into existe_sesion from sesion s where id_curso = v_id_curso;
	select coalesce(sum(num_horas_sesion), 0) into horas_sesion from sesion s where s.id_curso = v_id_curso;
	select coalesce(co.num_horas_totales, 0) from curso_online co where co.id = v_id_curso;

	if existe_curso = 1 and existe_sesion = 1
	then 
	
		update curso_online  
			set num_horas_totales = horas_sesion
		where id = v_id_curso;
	
	end if;

	
end;€€
DELIMITER
