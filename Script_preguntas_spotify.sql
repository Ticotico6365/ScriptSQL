
-- Ejercicio 1
select c.titulo as cancion, a.titulo as album, a.fecha_lanzamiento, a2.apodo as artista, c.duracion 
from cancion c 
join album a on a.id = c.id_album
join artista a2 on a2.id = a.id_artista;

-- Ejercicio 2
select u.nombre_completo as usuario, c.titulo as cancion, a2.apodo
from usuario u
join reproduccion r on u.id = r.id_usuario 
join cancion c on r.id_cancion = c.id
join album a on c.id_album = a.id 
join artista a2 on a2.id = a.id_artista ;

-- Ejercicio 3
select a.apodo , count(distinct c.id) as num_canciones
from artista a
join album a2 on a2.id_artista = a.id
join cancion c on c.id_album = a2.id
group by a.id;

-- Ejercicio 4
select a.titulo as albun, sec_to_time(sum(time_to_sec(c.duracion))) as suma_canciones
from album a
join cancion c on c.id_album = a.id
group by a.id;

-- Ejercicio 5
select a.apodo , timestampdiff(year, a.fecha_nacimiento, curdate()) as edad 
from artista a;

-- Ejercicio 6
select u.nombre_completo , sec_to_time(sum(time_to_sec(c.duracion))) as total_escuchado  
from usuario u
join reproduccion r on r.id_usuario = u.id
left join cancion c on r.id_cancion = c.id
group by c.id ;

-- Ejercicio 7
select  a.nombre_completo , count(distinct a2.id) as num_album, coalesce (sec_to_time(sum(time_to_sec(c.duracion))),0) as duracion_album
from artista a 
left join album a2 on a.id = a2.id_artista 
left join cancion c on c.id_album = a2.id
group by a.id;

-- if valor1 is null, muestra valor 2
-- coalesce(valor1, muestra valor2)

-- Ejercicio 8
select
	a.titulo as album,
	count(r.id_cancion) as num_reproducciones
from
	album a
join artista a2 on
	a2.id = a.id_artista
join cancion c on
	c.id_album = a2.id
join reproduccion r on
	r.id_cancion = c.id
group by
	a.id ;
limit 3;

-- Ejercicio 9 
select
	c.titulo as titulo_cancion,
	count(r.id_cancion),
	sec_to_time(sum(time_to_sec(c.duracion))) as duracion_canciones,
	a2.apodo as apodo_artista
from
	cancion c
join reproduccion r on
	r.id_cancion = c.id
join album a on
	a.id = c.id_album
join artista a2 on
	a2.id = a.id_artista
group by
	c.id
order by
	count(r.id_cancion) desc
limit 5;

-- Ejercicio 10
select *-- u.nombre_completo , r.id_cancion 
from usuario u 
join reproduccion r on r.id_usuario = u.id 
join cancion c on c.id = r.id_cancion ;
where r.id_cancion  = (select r2.id_cancion from reproduccion r2 group by r2.id_cancion order by count(r2.id_cancion) desc) 
group by u.id;


select r2.id_cancion , count(id_usuario)  from reproduccion r2 group by r2.id_cancion order by count(r2.id_cancion) desc ;

-- Ejercicio 11
select c.titulo as nombre_cancion, a.apodo as apodo_artista, a2.titulo as nombre_album ,count(c.id) as num_reproduciones
from cancion c 
join reproduccion r on r.id_cancion = c.id 
join usuario u on r.id_usuario = u.id
join album a2 on a2.id = c.id_album 
join artista a on a.id = a2.id_artista 
where u.pais = "España"
group by c.id 
order by count(c.id) desc 
limit 3;

-- Ejercicio 12 
select c.titulo as nombre_cancion, a.apodo as apodo_artista, a2.titulo as nombre_album ,sec_to_time(sum(time_to_sec(c.duracion))) as num_reproduciones
from cancion c 
join reproduccion r on r.id_cancion = c.id 
join usuario u on r.id_usuario = u.id
join album a2 on a2.id = c.id_album 
join artista a on a.id = a2.id_artista 
where u.pais = "UK"
group by c.id 
order by sec_to_time(sum(time_to_sec(c.duracion))) desc
limit 3;

select *
from cancion ;
select *
from album ;
select *
from reproduccion ;
select *
from artista ;
select * 
from usuario ;