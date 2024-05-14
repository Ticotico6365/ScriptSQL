
-- TRIGGERS

-- Ejercicio 1
DELIMITER €€
create or replace trigger reyenar_codigo_cliente
before insert on cliente
for each row 
begin 
	
	declare id_cliente int;

	select auto_increment into id_cliente from INFORMATION_SCHEMA.tables where TABLE_SCHEMA = "triggers_supermercado" and TABLE_NAME = "cliente";

	set new.codigo = concat('cc', id_cliente);
	
end; €€
DELIMITER


-- Ejercicio 2
DELIMITER €€
create or replace trigger rellenar_el_campo_hora_fin
before insert on tramo_horario
for each row
begin 
	
	set new.hora_fin = sec_to_time((time_to_sec(new.hora_inicio) + 3600));
	
end; €€
DELIMITER

-- Ejercicio 3
DELIMITER €€
create or replace trigger verificar_cliente
before update on cliente
for each row
begin 
	
	if length(new.telefono) != 9 and new.telefono not like "6%"
	then
	
		set new.telefono = old.telefono;
	
	end if;

	if new.email not like "%@gmail.com%" 
	then
		set new.email = old.email;
	
	end if;
	
end; €€
DELIMITER

-- FUNCIONES

-- Ejercicio 1

DELIMITER €€
create or replace function insertar_tramo_horario (v_hora_inicio time , v_dia_semana char(1))
returns varchar(100)
begin 
	
	declare existe_registro int;

	select count(*) into existe_registro from insertar_tramo_horarioinsertar_tramo_horarioinsertar_tramo_horario th 
	where th.hora_inicio = v_hora_inicio and th.dia_semana = v_dia_semana limit 1;
	
	if (date_format(v_hora_inicio, '%i') != '00' or date_format(v_hora_inicio, '%i') != '30') 
	and date_format(v_hora_inicio, '%S') != '00'and date_format(v_hora_inicio, '%H') > 24 then 
		
		return "formato horario no válido";
	
	end if;

	if v_dia_semana not in ("L", "M", "X", "J", "V", "S", "D") then 
	
		return "Día de la semana no válido";
	
	end if;

	if existe_registro = 1 
	then 
	
		return "Ya existe ese tramo horario";
	
	end if;
	
	return "Tramo horario creado con éxito";
	
end; €€
DELIMITER

DELIMITER €€
create or replace trigger verificar_tramo_horario
before insert on tramo_horario
for each row
begin 
	
	declare message varchar(100);

	select insertar_tramo_horario (new.hora_inicio, new.dia_semana) into message;

	if message != "Tramo horario creado con éxito" then 

		signal sqlstate '45000' set message_text = message;
	
	end if;
	
end; €€
DELIMITER




-- Ejercicio 2

DELIMITER €€
create or replace function  solicitar_reserva
(v_codigo_cliente varchar(100), v_num_mesa int, v_hora_inicio time, v_dia_semana char(1))
returns varchar(100)
begin 
	
	declare existe_cliente_codigo int;
	declare existe_numero_mesa int;
	declare existe_franja_horaria int;
	declare existe_reserva int;

	select count(*) into existe_cliente_codigo from cliente c where codigo = v_codigo_cliente ;
	select count(*) into existe_numero_mesa from mesa m where num_mesa = v_num_mesa limit 1;
	select count(*) into existe_franja_horaria from tramo_horario th where hora_inicio = v_hora_inicio and dia_semana = v_dia_semana;
	select count(*) into existe_reserva from reserva r 
	join tramo_horario th on th.id = r.id_tramo_horario 
	join mesa m on m.id = id_mesa 
	join cliente c on c.id = r.id_cliente 
	where c.codigo = "CC1" 
		and m.num_mesa = 1
		and th.hora_inicio = "20:00:00"
		and th.dia_semana = "L";

	if existe_cliente_codigo = 0 then 
		
		return "No se encontró cliente con el código introducido";
	
	end if;
	
	if existe_numero_mesa = 0 then 
		
		return "No se encontró mesa con el número introducido";
	
	end if;

	if existe_franja_horaria = 0 then 
	
		return "No se encontró tramo horario";
	
	end if;
	
	if existe_reserva = 1 then 
	
		return "Ya existe una reserva para el tramo horario solicitado";
	
	end if;

	return "Reserva realizada con éxito";
	
end; €€
DELIMITER

DELIMITER €€
create or replace trigger verificar_reserva
before insert on reserva
for each row
begin
	
	declare v_codigo_cliente varchar(100);
	declare v_hora_inicio time;
	declare v_dia_semana char(1);
	declare v_num_mesa int;
	declare message varchar(100);

	select codigo into v_codigo_cliente from cliente c where id = new.id_cliente;
	select num_mesa into v_num_mesa from mesa m where id = new.id_mesa;
	select hora_inicio into v_hora_inicio from tramo_horario th where id = new.id_tramo_horario;
	select dia_semana into v_dia_semana from tramo_horario th where id = new.id_tramo_horario;
	select solicitar_reserva(v_codigo_cliente, v_num_mesa, v_hora_inicio, v_dia_semana) into message;

	if message != "Reserva realizada con éxito" then 

		signal sqlstate '45000' set message_text = message;
	
	end if;
	
end; €€
DELIMITER




