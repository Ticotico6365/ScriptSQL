drop table if exists libro;

create table if not exists libro (
	id int(10) auto_increment,
	portada varchar(500),
	nombre varchar(100),
	autores varchar(200),
	precio double,
	descripcion text,
	ISBN varchar(17),
	primary key(id) 
);
alter database filo_egl_scraping character set utf8mb4 collate utf8mb4_general_ci;

/*alter table libro
character set utf8
collate utf8_general_ci;*/

select * from libro m;