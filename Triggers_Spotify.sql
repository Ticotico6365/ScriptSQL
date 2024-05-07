select * from cancion c ;

DELIMITER $$
create TRIGGER comprobar_duracion_maxima
BEFORE INSERT ON cancion
FOR EACH ROW
BEGIN
  IF NEW.duracion > "20:00:00"
    THEN
      SET NEW.duracion = "20:00:00";
  END IF ;
END$$
DELIMITER ;

INSERT INTO spotify.cancion
(id, titulo, duracion, id_album)
VALUES(16, 'Recordar', "50:00:00", 6);

select * from cancion c ;

select duracion > "00:01:00" from cancion c where id = 1;


select * from artista a ;


#Vamos a comrprobar que cuando se inserta un nuevo artista
# la fecha de nacimiento es anterior a 1-1-2004

DELIMITER && 
create trigger comprobar_fecha_nacimiento
before insert  on artista
for each row 
begin 	
	if new.fecha_nacimiento > "2004-01-01" then 
		set new.fecha_nacimiento = "2004-01-01";
	end if;
end
&&
DELIMITER

select * from artista a ;

insert into artista (apodo,pais, nombre_completo, fecha_nacimiento)
values ("El Koala", "España", "El Koala", "1984-02-01");


DELIMITER && 
create trigger comprobar_borrar_artista
before delete  on artista
for each row 
begin 	
	
	declare num_canciones int(10) default 0;

	select count(*) into num_canciones from cancion c 
	join album a on c.id_album  = a.id
	where a.id_artista  = old.id;

	if num_canciones > 0 then 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede borrar un artista si tiene canciones.';
	end if;
	
end
&&
DELIMITER

delete from artista  where id = 14;



select * from artista a ;

select count(*) from cancion c 
join album a on c.id_album  = a.id
where a.id_artista  = 1;



select * from cancion c ;

create table cancion_historico(
	id int(10) auto_increment, 
	id_cancion int(10),
	antigua_duracion time,
	fecha_cambio datetime,
	primary key(id),
	constraint fk_cancion_historico_cancion foreign key (id_cancion) references cancion(id)
);


DELIMITER && 
create trigger actualizar_cancion_historico
after update  on cancion
for each row 
begin 	
	
	insert into cancion_historico (id_cancion, antigua_duracion, fecha_cambio)
	values (new.id, old.duracion , curdate());
end
&&
DELIMITER

select * from album a ;


select * from cancion c  ;
select * from cancion_historico;

update cancion  set duracion= "04:20:00" where id= 1;
















-- MIO
select * from cancion c ;

update from album set fecha_lanzamiento = now()
where id = new.id_album;

-- Ejercicio 1
DELIMITER $$
	create trigger actualiza_fecha_album
	after insert on cancion
	for each row
	begin
		update album set fecha_lanzamiento = now()
		where id = new.id_album;
	end; $$
DELIMITER

insert into cancion (titulo, duracion, id_album)
values ("pepe", "03:05:00", 2);

select * from cancion c ;
select * from album a ;

-- Ejercicio  2
DELIMITER €€
create trigger comprobar_album_valido_eliminacion
before delete on album
for each row
begin 
    declare num_canciones_album int(10);
    select count(*) into num_canciones_album from cancion c where id_album = old.id;
    if num_canciones_album > 0 then
        signal sqlstate '45000' set message_text = "no se puede eliminar el álbum con canciones asociadas.";
    end if;
end;
€€
DELIMITER

select * from album a ;
select count(*) from cancion c where id_album = 1 ;

-- Ejercicio 3
DELIMITER €€
create trigger eliminar_artista_sin_album
after delete on album
for each row 
begin 
	declare tiene_album int;
	
	select count(*) into tiene_album from album where id_artista = old.id_artista;
	
	if tiene_album = 0 then
		delete from cancion c where id_album = old.id;
		delete from artista where id = old.id_artista;
	end if;
	
end; €€
DELIMITER

insert into album (titulo, fecha_lanzamiento, id_artista)
values ("La rosa", "2023-01-20", 13);

insert into artista (nombre_completo, apodo, pais, fecha_nacimiento)
values ("David Zamora Martínez", "Hidrati", "España", "2005-09-09");

select * from album a ;
delete from album where id = 9;
select * from artista a ;

-- Ejercicio 4
drop table if exists registro_auditoria;

create table if not exists registro_auditoria (
	id int(10) auto_increment not null,
	id_cancion int(10) not null,
	id_usuario int(10) not null,
	fecha_reproduccion date not null,
	primary key (id),
	constraint fk_cancion_usuario foreign key (id_cancion) references cancion(id),
	constraint fk_usuario_cancion foreign key (id_usuario) references usuario(id)
);
drop trigger registrar_canciones_usuarios;
DELIMITER €€
create trigger registrar_canciones_usuarios
after insert on reproduccion
for each row
begin
	insert into registro_auditoria (id_usuario, id_cancion, fecha_reproduccion)
	values (new.id_usuario, new.id_cancion, current_date());
end; €€
DELIMITER ;

select * from reproduccion r ;

insert into reproduccion (id_cancion, id_usuario, fecha_reproduccion)
values (1, 1, year(current_date()));

select * from registro_auditoria ;

-- Ejercicio 5 
drop table if exists cuenta_reproduccion_cancion;
create table if not exists cuenta_reproduccion_cancion (
	id int(10) auto_increment not null,
	id_cancion int(10) not null,
	id_usuario int(10) not null,
	num_reproducciones int(10) not null default 0,
	primary key (id),
	constraint fk_cancion_usuario foreign key (id_cancion) references cancion(id),
	constraint fk_usuario_cancion foreign key (id_usuario) references usuario(id)
);


