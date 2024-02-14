drop table if exists 

create table if not exists refugio(
	id int(10) auto_increment,
	nombre varchar(150) not null,
	dirección varchar(200),
	capacidad int(10),
	primary key(id)
);

create table if not exists cliente(
	id int (10) auto_increment,
	nombre varchar (50),
	apellidos varchar (50),
	dni varchar (9),
	primary key(id)
);

create table if not exists animal(
	id int (10) auto_increment,
	especie varchar (150),
	raza varchar (50),
	es_salvaje bool,
	es_domestico bool,
	primary key(id)
);

create table if not exists mascota(
	id int (10) auto_increment,
	nombre varchar (150),
	peso double,
	id_animal int(10),
	primary key(id),
	constraint mascota_animal_fk foreign key (id_animal) references animal(id)
);


create table if not exists mascota_refugio(
	id_refugio int (10),
	id_mascota int (10),
	constraint mascota_refugio_refugio_fk foreign key (id_refugio) references refugio(id),
	constraint mascota_refugio_mascota_fk foreign key (id_mascota) references mascota(id)
);

create table if not exists adopcion(
	id int (10) auto_increment,
	codigo varchar (50),
	id_cliente int(10),
	id_refugio int(10),
	id_mascota int(10),
	primary key (id),
	constraint adopcion_cliente_fk foreign key (id_cliente) references animal(id),
	constraint adopcion_refugio_fk foreign key (id_refugio) references refugio(id),
	constraint adopcion_mascota_fk foreign key (id_mascota) references mascota(id)
);
