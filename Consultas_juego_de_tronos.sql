-- consulta 1
select * from personaje p where id_casa = (select id from casa where apellido = "Stark");
-- Primero buscamos los personajes y dentro buscamoel el id_casa dentro de la tabla casas

-- Consulta 2
select * from personaje p where id_casa = (select id from casa where blossom = "Bastardos");

-- consulta 3
select * from personaje p where sexo = "M";

-- consulta 4
select * from personaje p where sexo = "F";

-- consulta 5
select * from personaje p order by fecha_nacimiento; -- por defecto está el orden ascendente

-- consulta 6
select * from personaje p order by fecha_nacimiento desc limit 5;

-- consulta 7
select * from personaje p where apodo like '%dragón%';

-- consulta 8
select * from personaje p where apodo = "" or apodo is null;

-- consulta 9
select * from personaje p order by fuerza desc limit 5;

-- consulta 10
select * from personaje p order by inteligencia desc limit 5;

-- consulta 11 
select * from personaje p order by influencia desc limit 10;

-- consulta 12
select nombre, timestampdiff(year , fecha_nacimiento, current_date()) from personaje p ;

-- consulta 13
select nombre, max(influencia) from personaje p group by id_casa;

-- consulta 14
select p.nombre, r.nombre, r.extension from personaje p join casa c on c.id = p.id_casa join castillo c2 on c.id = c2.id_reino join reino r where r.extension < 50000 ;

-- consulta 15
select * from 

select * from reino r ;
select * from casa;
select * from personaje p ;
select * from castillo c;