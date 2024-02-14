-- Ejercicio 1
	-- apartado 1
select id numero, nombre mascota, id_refugio refujio, peso, id_animal animal 
from mascota m ;

select * from mascota m ;

	-- apartado 2
select * 
from mascota 
where id_refugio = 3 or id_refugio = 2 and peso <> 6 and nombre like 'L%';

	-- apartado 3
select * 
from mascota m 
where peso between 6 and 13;

	-- apartado 4
select * 
from mascota 
where nombre like 'L%';

	-- apartado 5
select * 
from mascota 
where nombre in (select nombre from mascota m where id = 10) ;

	-- apartado 6
select * 
from mascota m 
order by peso desc 
limit 5;

	-- apartado 7 
select id_refugio, count(distinct nombre) as num_animales, sum(distinct peso) as masa_animales_refugio 
from mascota m 
group by id_refugio ;

	-- apartado 8
select *   
from mascota m
where id_refugio = (select id from refugio r where nombre = "La Gran Acogida");

-- Ejercicio 2
	-- apartado 1
select especie, count(distinct raza) as num_raza 
from animal a 
group by especie ;

	-- apartado 2
select es_salvaje , count(distinct especie) as num_especie 
from animal a 
group by es_salvaje ;

	-- apartado 3
select es_domestico , count(distinct especie) as num_especie 
from animal a 
group by es_domestico ;

	-- apartado 4
select a.especie , round(avg(distinct m.peso), 3) as peso  
from mascota m 
join animal a on a.id = m.id_animal 
group by a.especie ;

	-- apartado 5
select id_refugio , count(distinct id) as num_mascotas 
from mascota m  
group by id_refugio ;

	-- apartado 6
select id_refugio, count(distinct id) as num_mascotas  
from mascota m 
where id not in (select id_mascota from adopcion a)
group by id_refugio ;

	 -- apartado 7
select c.nombre , count(distinct id_mascota) as num_mascotas  
from adopcion a 
right join cliente c ON c.id = a.id_cliente 
group by id_cliente ;

	-- apartado 8
select id_refugio, count(distinct id) as num_adopciones 
from adopcion a 
group by id_refugio ;


-- Ejercicio 3
select c.nombre as datos_cliente, m.nombre as mascota, r.nombre as refugio, a2.especie, a2.raza 
from cliente c 
join adopcion a on c.id = a.id_cliente
join mascota m on m.id = a.id_mascota
join refugio r on r.id = m.id_refugio 
join animal a2 on a2.id = m.id_animal ;


-- EXTRAS




select *
from animal a ;
select *
from mascota m ;
select *
from mascota_refugio mr ;
select *
from adopcion a ;
select * 
from cliente c ;
