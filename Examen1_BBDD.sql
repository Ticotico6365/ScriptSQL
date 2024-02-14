drop table if exists imagen;
drop table if exists hermandad_hermano;
drop table if exists hermandad;
drop table if exists hermano;
drop table if exists templo;

create table if not exists templo (
    id int(10) auto_increment not null,
    nombre varchar(250) not null,
    ubicacion varchar(300) not null,
	tipo int(1),
    primary key (id)
);

create table if not exists hermano (
    id int(10) auto_increment not null,
    nombre varchar(100) not null,
    apellidos varchar(100) not null,
    dni varchar(10) not null,
	fecha_nacimiento date,
    primary key (id)
);

create table if not exists hermandad (
    id int(10) auto_increment not null,
    nombre varchar(500) not null,
    apodo varchar(100) not null,
    carrera_oficial boolean,
	fecha_fundacion date,
	id_templo int(10),
    primary key (id),
    constraint fk_hermandad_templo foreign key (id_templo) references templo(id)
);

create table if not exists hermandad_hermano (
	id_hermano int(10),
	id_hermandad int(10),
	constraint fk_hermandad_hermano_hermano foreign key (id_hermano) references hermano(id),
    constraint fk_hermandad_hermano_hermandad foreign key (id_hermandad) references hermandad(id)
);

create table if not exists imagen (
    id int(10) auto_increment not null,
    nombre varchar(500) not null,
    tipo int(1) not null,
    anyo_creacion year,
	titular boolean,
	procesiona boolean,
	id_hermandad int(10),
    primary key (id),
    constraint fk_imagen_hermandad foreign key (id_hermandad) references hermandad(id)
);

insert into templo (nombre, ubicacion, tipo) values 
		("Jesús de la veracruz", "C/Jesús de la veracruz", "1"),
       ("Jesús del Gran Poder", "C/Jesús del Gran Poder", "2"),
       ("Santisima Aguasanta", "C/La Parra", "3"),
       ("Setefilla", "C/Libre expiración", "4"),
       ("Museo", "C/AlfonsoXII", "5");

select * from templo;

insert into hermano (nombre, apellidos, dni, fecha_nacimiento) values 
		("David", "Zamora", "77871552S", "2005-09-09"),
       ("Lola", "Gonzalez", "55478963V", "2005-08-13"),
       ("Aguasanta", "Jimenez", "78945612L", "1954-05-15"),
       ("Óscar", "Chen", "78J885KP15", "2004-07-12"),
       ("Triana", "Caparros", "56974523K","2009-05-12");

select * from hermano;

insert into hermandad (nombre, apodo, carrera_oficial, fecha_fundacion, id_templo) values 
		("El Museo", "La expiracion", 1, "1789-09-09", 1),
       ("El Gran Poder", "El sueño de Marcelo", 0, "1509-08-13", 2),
       ("Señora Aguas santas", "La chiquitita", 0, "1854-05-15", 3),
       ("Setefilla", "La serranita hermosa", 1, "1874-07-12", 4),
       ("Triana", "La dolorosa", 0,"1465-05-12", 5);
select * from hermandad ;

insert into hermandad_hermano (id_hermano, id_hermandad) values 
		(1, 1),
       (2, 2),
       (3, 3),
       (4, 4),
       (5, 5);
      
select * from hermandad_hermano ;

insert into imagen (nombre, tipo, anyo_creacion, titular, procesiona, id_hermandad) values 
		("Virgen de las Aguas", 2, "1998", 1, 1, 1),
       ("Cristo del Gran Poder", 5, "1989", 1, 0, 2),
       ("Virgen de Aguas santas", 1, "1990", 0, 0, 3),
       ("Virgen de Setefilla", 9, "1901", 1, 0, 4),
       ("Cristo de la expiración", 6, "1998", 1, 1, 5);
select * from hermandad ;
