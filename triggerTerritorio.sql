-- Ejercicio 1
DELIMITER €€
create or replace trigger borra_edificio
before delete on calle
for each row
begin
    declare tiene_edificios int;

    select count(*) into tiene_edificios from edificio e where id_calle = old.id limit 1;

    if tiene_edificios = 1 then
        delete from edificio where id_calle = old.id;
    end if;
end; €€
DELIMITER

delete from calle where id = 2;
select * from calle c ;
select * from edificio e ;

-- Ejercicio 2
create table if not exists historico_vecinos_edificio (
    id int(10) auto_increment not null,
	id_edificio int(10),
	num_habitantes int(10), 
	fecha date,
    primary key (id)
);


DELIMITER €€
create or replace trigger insert_historico_vecinos_edificio
after update on edificio
for each row
begin
	
	insert into historico_vecinos_edificio (id_edificio, num_habitantes, fecha)
	values (old.id, old.num_vecinos, current_date());
	
end; €€
DELIMITER

select * from edificio e ;
update edificio 
	set num_vecinos = 20
where id = 2;
select * from historico_vecinos_edificio hve ;

-- Ejercicio 3
DELIMITER €€
create or replace trigger ver_calles_ciudad
before delete on ciudad
for each row
begin
	declare tiene_calle int;

	select count(*) into tiene_calle from barrio b join calle c on c.id_barrio = b.id where b.id_ciudad = old.id limit 1;

	if tiene_calle = 1 then
	
		signal sqlstate '45000' set message_text = 'No se puede eliminar un ciudad con calles asociadas, pruebe a eliminar antes las calles';	
	
	end if;
end; €€
DELIMITER

-- Ejercicio 4
DELIMITER €€
create or replace trigger ajuste_poblacion_insert
before insert on provincia
for each row
begin

	update comunidad_autonoma 
		set habitantes = habitantes + new.habitantes
	where id = new.id_comunidad_autonoma;
	
end; €€
DELIMITER

DELIMITER €€
create or replace trigger ajuste_poblacion_update
after update on provincia
for each row
begin

		update comunidad_autonoma 
			set habitantes = habitantes + (old.habitantes - new.habitantes)
		where id = new.id_comunidad_autonoma;
	
end; €€
DELIMITER

-- Ejercicio 5
select * from barrio;

DELIMITER €€
create or replace trigger barrio_sin_direccion
before insert on barrio
for each row
begin
	declare direccion_ciudad varchar(100);
	
	select c.direccion into direccion_ciudad from barrio b join ciudad c on c.id = b.id_ciudad where b.id = new.id;

	if new.direccion is null then
	
		set new.direccion = direccion_ciudad;
	
	end if;
	
end; €€
DELIMITER

