drop if exists

create table if not exists escuderia(
	id int(10) auto_increment primary key,
	nombre varchar(100),
	fecha_fundacion date
);
create table if not exists gran_premio(
	id int(10) auto_increment primary key,
	fecha date,
	ubicacion varchar(255)
);

create table if not exists piloto(
	id int(10) auto_increment primary key,
	nombre varchar(100),
	apellidos varchar(100)
);

