
-- Borrar tablas --
drop table helado_sabor ;-- no se puede borrar tablas que están relacionadas, para borrar hay que empezar por la de mayor número de relaciones --
drop table helado_ingrediente ;
drop table helado_complemento ;
drop table complemento ;
drop table sabor ;
drop table helado ;
drop table ingrediente ;
drop table heladeria ;

-- creación tabla heladería --
create table heladeria (
	id int(10) auto_increment not null, -- el id por defecto ya no puede ser nulo --
	nombre varchar(50) not null,
	direccion varchar(50) not null,
	fecha_fundacion date,
	popularidad int(2),
	primary key(id) 
);



create table ingrediente(
	id int(10) auto_increment,
	tiene_lactosa bool default true, -- mete por defecto el vaor true, así se evitan los nulos --
	tiene_gluten bool default true,
	nombre varchar(50) not null,
	primary key (id)
);

create table helado (
	id int(10) auto_increment,
	nombre varchar(50) not null,
	tipo int(1) default 0,
	precio double not null,
	id_heladeria int(10) not null,
	primary key (id),
	constraint helado_heladria_fk foreign key (id_heladeria) references heladeria(id) -- relación (como los nombres no se pueden repetir se pone distinto) --
);


create table sabor(
	id int(10) auto_increment,
	nombre varchar(50) not null,
	tipo int(1) default 0,
	precio double,
	primary key (id)
);

create table complemento(
	id int(10) auto_increment,
	nombre varchar(50) not null,
	precio double,
	primary key(id)
);

create table helado_complemento(
	id_helado int(10) not null,
	id_complemento int(10) not null,
	constraint helado_complemento_helado_fk foreign key (id_helado) references helado(id),
	constraint helado_complemento_complemento_fk foreign key (id_complemento) references complemento(id)
);

create table helado_ingrediente(
	id_helado int(10) not null,
	id_ingrediente int(10) not null,
	constraint helado_ingrediente_helado_fk foreign key (id_helado) references helado(id),
	constraint helado_ingrediente_ingrediente_fk foreign key (id_ingrediente) references ingrediente(id)
);

create table helado_sabor(
	id_helado int(10) not null,
	id_sabor int(10) not null,
	num_bolas int(1) not null,
	constraint helado_sabor_helado_fk foreign key (id_helado) references helado(id),
	constraint helado_sabor_sabor_fk foreign key (id_sabor) references sabor(id)
);
