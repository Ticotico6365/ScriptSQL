create table if not exists empresa (
    id int(10) auto_increment not null,
	codigo_empresa int(10),
	cif varchar(100),
	nombre_empresa varchar(100),
	direccion varchar(100),
	codigo_postal varchar(100),
	localidad varchar(100),
	jornada varchar(100),
	modalidad varchar(100),
	mail varchar(1000),
	dni_responsable_legal varchar(50),
	dni_tutor_legal varchar(50),
	nombre_responsable_legal varchar(100),
	nombre_tutor_laboral varchar(100),
	apellidos_responsable_legal varchar(200),
	apellidos_tutor_laboral varchar(200),
	telefono_tutor_laboral varchar(100),
    primary key (id)
);

create table if not exists alumno (
    id int(10) auto_increment not null,
	nombre varchar(100),
	apellidos varchar(200),
	dni varchar(10),
	fecha_nacimiento date,
    primary key (id)
);

create table if not exists tutor (
    id int(10) auto_increment not null,
	nombre varchar(100),
	aoellidos varchar(200),
	correo_electronico varchar(500),
	telefono varchar(50),
    primary key (id)
);



