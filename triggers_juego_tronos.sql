-- Ejercicio 1
drop trigger alianzas_casas;
DELIMITER €€
create trigger alianzas_casas
before insert on alianza
for each row 
begin 
	
	declare existe_alianza int;
	
	select count(*) into existe_alianza from alianza where id_casa = new.id_casa and id_aliado = new.id_aliado;

	if existe_alianza = 1 then
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Esa alianza ya existe';
	end if;
	
end;€€
DELIMITER
select * from alianza ;
insert into alianza (id_aliado, id_casa)
values (2, 2);

-- Ejercicio 2
select * from matrimonio ;
alter table matrimonio 
add fecha_matrimonio date;


drop trigger poner_fecha_matrimonio_insert;
DELIMITER €€
create trigger poner_fecha_matrimonio_insert
before insert on matrimonio
for each row
begin
    set new.fecha_matrimonio = current_date();
end; €€
DELIMITER

drop trigger poner_fecha_matrimonio_update;
DELIMITER €€
create trigger poner_fecha_matrimonio_update
before update on matrimonio
for each row
begin
    set new.fecha_matrimonio = current_date();
end;€€
DELIMITER

insert into matrimonio (id_marido, id_mujer, fecha_matrimonio)
values (1, 1, "2005-09-09");
select * from matrimonio ;

update matrimonio 
	set id_marido = 2
where id_marido = 1 and id_mujer = 1;


-- Ejercicio 3
select * from ejercito e ;
alter table ejercito 
add total_ejercito int(10);

drop trigger total_ejercito;
DELIMITER €€
create trigger total_ejercito
before insert on ejercito
for each row 
begin 
	
	set new.total_ejercito = new.infanteria + new.caballeria + new.arqueros;
	
end; €€
DELIMITER
select * from ejercito e ;
insert into ejercito (infanteria, caballeria, arqueros, id_casa)
values (1, 1, 1, 1);


-- Ejercicio 4
select * from personaje p ;
DELIMITER €€
create trigger personas_mayores
before insert on personaje
for each row 
begin 
	
	declare edad int;

	select timestampdiff(year, new.fecha_nacimiento, current_date()) into edad;
	
	if edad < 18 then
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Alerta menor de edad';
	end if;
	
end; €€
DELIMITER

insert into personaje 
values (37, "David", "Hidrati", "M", "2006-09-09", 100, 100, 100, 100, 21);

select * from personaje p ;

select timestampdiff(year, "2005-09-09", current_date());

-- Ejercicio 5
select * from casa c ;
alter table casa 
add total_aptitudes int(10);

drop trigger total_aptitudes_casa_insert;
DELIMITER €€
create trigger total_aptitudes_casa_insert
after insert on personaje
for each row
begin 
	
	update casa 
		set total_aptitudes = total_aptitudes + new.fuerza + new.destreza + new.inteligencia + new.influencia
	where new.id_casa = id;
		
end; €€
DELIMITER

select * from casa c ;
insert into personaje 
values (37, "Pepe", "Filemón", "M", "1980-04-18", 10, 10, 10, 10, 20);

DELIMITER €€
create trigger total_aptitudes_casa_update
after update on personaje
for each row
begin 
	
	update casa 
		set total_aptitudes = new.fuerza + new.destreza + new.inteligencia + new.influencia
	where new.id_casa = id;
		
end; €€
DELIMITER
select c.total_aptitudes from personaje p join casa c on c.id = p.id_casa ;

update casa 
	set total_aptitudes = 0
where id = 20;
select * from casa c ;

update personaje 
	set inteligencia = 1
where id = 37;
select * from casa c ;


DELIMITER €€
create trigger total_aptitudes_casa_delete
after delete on personaje
for each row
begin 
	
	update casa 
		set total_aptitudes = total_aptitudes - old.fuerza - old.destreza - old.inteligencia - old.influencia
	where old.id_casa = id;
		
end; €€
DELIMITER

-- Ejercicio 6

DELIMITER €€
create trigger recalcula_extension_reino
after insert on castillo
for each row
begin
    declare num_castillos int;
    declare id_reino int;

    set id_reino = new.id_reino;

    select count(*) into num_castillos from castillo where id_reino = id_reino;

    update reino set extension = num_castillos * 10000 where id = id_reino;
end;€€
DELIMITER

-- Ejercicio 7

DELIMITER €€
create trigger prevent_character_deletion
before delete on personaje
for each row
begin
    declare num_personajes int;

    select count(*) into num_personajes from personaje where id_casa = old.id_casa;

    if num_personajes = 1 then
        signal sqlstate '45000'set message_text = 'no se puede eliminar el personaje. es el único en su casa.';
    end if;
end; €€
DELIMITER

