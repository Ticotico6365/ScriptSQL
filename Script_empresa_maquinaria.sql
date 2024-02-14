-- Ejercicio 1
select *
from trabajador t 
join maquinaria m on m.trabajador_id = t.id ;

-- Ejercicio 2
select *
from contrato c
where c.monto > (select avg(monto) from contrato );

-- Ejercicio 3
select c.nombre as nombre_contrato , o.nombre as nombre_organizacion 
from contrato c 
join area a on a.id = c.area_id 
join organizacion o on o.id = a.organizacion_id ;

-- Ejercicio 4
select a.nombre ,sum(c.monto) as monto_por_area
from contrato c 
join area a on a.id = c.area_id 
group by a.id ;

-- Ejercicio 5
select t.nombre ,t.apellidos ,count(m.id) as num_maquinas_por_trabajador
from trabajador t 
join maquinaria m on m.trabajador_id = t.id 
group by t.id 
having count(m.id) > 1;

-- Ejercicio 6
select t.nombre, t.apellidos 
from trabajador t 
left join maquinaria m on m.trabajador_id = t.id 
group by t.id 
having count(m.id) < 1;

-- Ejercicio 7
select c.nombre ,timestampdiff(day ,c.fecha_inicio , c.fecha_fin) as dias_vijentes
from contrato c 
order by dias_vijentes desc ;

-- Ejercicio 8
select c.nombre, timestampdiff(day ,i.fecha_inicio , i.fecha_fin) as dias_vigor, e.nombre 
from contrato c
join interviniente i on i.contrato_id = c.id 
join empresa e on e.id = i.empresa_id ;

-- Ejercicio 9
select c.nombre , c.fecha_inicio , c.fecha_fin 
from contrato c 
join tipo_contrato tc on tc.id = c.tipo_contrato_id 
where tc.nombre = "Permanente" and 
	(c.fecha_inicio between "2022-01-01" and "2022-03-31" or 
	c.fecha_fin between "2022-03-31" and "2022-01-01" or 
	c.fecha_inicio < "2022-01-01" and c.fecha_fin > "2022-03-31");

-- Ejercicio 10
select avg(c.monto) 
from contrato c
join interviniente i on i.contrato_id = c.id 
join empresa e on e.id = i.empresa_id 
where e.nombre = "EnergySur";

-- Ejercicio 11
select e.nombre, c.nombre , i.fecha_inicio , i.fecha_fin 
from empresa e 
join interviniente i on i.empresa_id = e.id 
join contrato c on c.id = i.contrato_id 
where i.fecha_inicio <= curdate() and i.fecha_fin >= curdate() ;

-- Ejercicio 12
select e.nombre, c.nombre
from empresa e 
join interviniente i on i.empresa_id = e.id 
join contrato c on c.id = i.contrato_id 
group by e.id ,c.id 
having count(c.id) > 1 ; 

-- Ejercicio 13
select round(avg(timestampdiff(year, t.fecha_nacimiento, curdate()))) as media_edad
from trabajador t 
join empresa e on e.id = t.empresa_id 
group by t.empresa_id ;

select *
from trabajador t ;
select *
from maquinaria m ;
select *
from contrato c ;
select avg(monto)
from contrato  ;