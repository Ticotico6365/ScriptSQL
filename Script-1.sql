create table cadena_tv(
	id int(10) auto_increment,
	nombre varchar(50) not null,
	descripcion varchar(100),
	abreviatura char(5) not null,
	primary key(id)
)
create table programa(
	id int(10) auto_increment,
	nombre varchar(100) not null,
	tipo_publico int(1) not null,
	tipo_programa int(1) not null,
	descripcion varchar(100),
	id_cadena int(10),

)