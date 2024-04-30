select * from cancion c ;

update from album set fecha_lanzamiento = now()
where id = new.id_album;

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