drop table if exists libro;

create table if not exists libro (
	id int(10) auto_increment,
	portada varchar(500),
	nombre varchar(200),
	autores varchar(500),
	precio double,
	isbn varchar(25),
	tipo varchar(50),
	primary key(id) 
);


select * from libro ;

select * from libro where tipo = 'libros de viaje' ;

ALTER DATABASE `filo_egl`
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_unicode_ci;