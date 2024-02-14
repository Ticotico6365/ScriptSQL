drop table if exists equipo_partido;
drop table if exists estadistica;
drop table if exists atributos;
drop table if exists quimica;
drop table if exists jugador;
drop table if exists equipo;
drop table if exists partido;
drop table if exists liga;
drop table if exists estadio;
drop table if exists entrenador;


create table if not exists entrenador (
    id int(10) auto_increment not null,
    nombre varchar(100) not null,
    apellidos varchar(100) not null,
    nacionalidad varchar(100) not null,
    primary key (id)
);

create table if not exists estadio (
    id int(10) auto_increment not null,
    anyo year not null,
    ciudad varchar(100) not null,
    pais varchar(100) not null,
    capacidad int(10) not null,
    primary key (id)
);

create table if not exists liga (
    id int(10) auto_increment not null,
    num_equipos int(10) not null,
    pais varchar(100) not null,
    premio_1 int(10) not null,
    premio_2 int(10) not null,
    premio_3 int(10) not null,
    premio_4 int(10) not null,
    premio_5 int(10) not null,
    primary key (id)
);

create table if not exists partido (
    id int(10) auto_increment not null,
    fecha date not null,
    resultado varchar(100) not null,
    primary key (id)
);

create table if not exists equipo (
    id int(10) auto_increment not null,
    nombre varchar(100) not null,
    abreviatura char(3) not null,
    url varchar(200) not null,
    id_entrenador int(10),
    id_liga int(10),
    id_estadio int(10),
    primary key (id),
    constraint fk_equipo_entrenador foreign key (id_entrenador) references entrenador(id),
    constraint fk_equipo_liga foreign key (id_liga) references liga(id),
    constraint fk_equipo_estadio foreign key (id_estadio) references estadio(id)
);

create table if not exists jugador (
    id int(10) auto_increment not null,
    nombre varchar(100) not null,
    apellidos varchar(100) not null,
    nacionalidad varchar(100) not null,
    posicion varchar(4) not null,
    id_equipo int(10),
    primary key (id),
    constraint fk_jugador_equipo foreign key (id_equipo) references equipo(id)
);

create table if not exists quimica (
    id_jugador1 int(10),
    id_jugador2 int(10),
    a_liga bool not null,
    a_pais bool not null,
    a_equipo bool not null,
    a_total int(10) not null,
    constraint fk_quimica_jugador1 foreign key (id_jugador1) references jugador(id),
    constraint fk_quimica_jugador2 foreign key (id_jugador2) references jugador(id)
);

create table if not exists atributos (
    id int(10) auto_increment not null,
    ritmo int(10),
    tiro int(10),
    pase int(10),
    regate int(10),
    defensa int(10),
    fisico int(10),
    id_jugador int(10),
    primary key (id),
    constraint fk_atributos_jugador foreign key (id_jugador) references jugador(id)
);


create table if not exists estadistica (
    id_jugador int(10),
    id_partido int(10),
    goles int(2) not null,
    asistencias int(2) not null,
    t_amarilla int(1) not null,
    t_roja bool not null,
    constraint fk_estadistica_jugador foreign key (id_jugador) references jugador(id),
    constraint fk_estadistica_partido foreign key (id_partido) references partido(id)
);

create table if not exists equipo_partido (
    id_partido int(10),
    id_equipo int(10),
    es_local bool not null,
    constraint fk_equipo_partido_partido foreign key (id_partido) references partido(id),
    constraint fk_equipo_partido_equipo foreign key (id_equipo) references equipo(id)
);

/*inserción de datos*/

     insert into estadio (capacidad, ciudad, pais, anyo) values 
	       ("72698", "Roma", "Italia", "1953"),
       ("74475", "Berlín", "Alemania","1936"),
       ("81500", "Moscú", "Rusia", "1956"),
       ("69618", "Atenas", "Grecia", "1982"),
       ("65647", "Lisboa", "Portugal", "2003"),
       ("43883", "Sevilla", "España", "1958"),
       ("60721", "Sevilla", "España", "1929"),
       ("55000", "Nápoles", "Italia","1959"),
       ("90000", "Londres", "Inglaterra", "2007"),
       ("67394", "Marsella", "Francia", "1938"),
       ("84738", "Rio de Janerio", "Brasil", "1950"),
       ("83264", "Ciudad de México", "Mexico", "1966"),
       ("54000", "Buenos Aires", "Argentina", "1940 "),
       ("114000", "Pionyang", "Corea del Norte", "1989"),
       ("65000", "Bangkok", "Tailandia", "1998"),
       ("21000", "Miami", "Estados_Unidos", "2020"),
       ("80093", "Lima", "Peru", "2000"),
       ("43086", "Lima", "Peru", "1952"),
       ("42000", "Cusco", "Peru", "1950"),
       ("40370", "Arequipa", "Peru", "1995"),
       ("30044", "Málaga", "España", "1941"),    
       ("68000", "Tánger", "Marruecos","2010"),
       ("36462", "Bolonia", "Italia", "1927"),
       ("42052", "Bordeaux", "Francia", "2015"),
       ("60044", "Recife", "Brasil", "1972");


insert into entrenador (id,nombre,apellidos,nacionalidad)
values (1,"Diego", "Alonso", "uruguay"),
	   (2,"Josep", "Guardiola", "español"),
	   (3,"Xavier", "Hernández", "español"),
	   (4,"Simone", "Inzaghi", "italiano"),
	   (5,"Edward John", "Howe", "inglés"),
	   (6,"Manuel", "Pellegrini", "chileno"),
	   (7,"Luis", "Enrique", "español"),
	   (8,"Mikel", "Arteta", "español"),
	   (9,"Thomas", "Tuchel", "aleman"),
	   (10,"Carlo", "Ancelotti", "italiano"),
	   (11,"Zinedine", "Zidane", "frances"),
	   (12,"Diego", "Simeone", "argentino"),
	   (13,"Josep", "Mouriho", "portugues"),
	   (14,"Unay", "Emery", "español"),
	   (15,"Ronald", "koeman", "paises bajos"),
	   (16,"Alexander", "Ferguson", "britanico"),
	   (17,"ten", "hag", "aleman"),
	   (18,"Sergio", "González", "español"),
	   (19,"Marcelino", "Garcíai", "español"),
	   (20,"José", "Bordalás", "español");

insert into liga (id, num_equipos, pais, premio_1, premio_2, premio_3, premio_4, premio_5)
values (1,20,"España", 61300000, 54100000, 46900000, 39700000, 32400001),
	   (2, 20, "Italia", 23400000, 19400000, 16800000, 14000000, 12500000),
	   (3, 18, "Alemania ",56500000, 51000000, 47000000, 32000000, 26000000),
	   (4, 20, "Inglaterra", 52000000, 49000000, 46000000, 44000000, 200000),
	   (5, 37, "Argentina", 51500000, 46600001, 41600000, 36000000, 28200001),
	   (6, 18, "Arabia Saudi", 3000000,2000000,1000000,500000,200000),
	   (7, 18, "Paises Bajos",5500000, 4500000, 4000000, 3000000, 2000000),
	   (8, 15, "Estados Unidos ",10000000, 8000000, 6000000, 6500000,5000000),
	   (9, 18, "Francia", 6000000, 5000000, 5500000, 4500000, 1000000),
	   (10, 16, "Suecia", 9000000, 8000000, 6000000, 5000000, 3000000),
	   (11, 10, "Albania", 79563123, 65000000, 55000000, 49500100, 36020450 ),
	   (12, 16, "Rusia", 80003103, 78500960, 66000001, 59705201, 41120000 ),
	   (13, 12, "Dinamarca", 96800500, 88870100, 73570001, 6222200, 52120000),
	   (14, 18, "Egipto", 30000000, 26970003, 15620001, 10702020, 8000000),
	   (15, 20, "Brasil",19230000, 13000000, 12890901, 9202000, 2000000),
	   (16, 16, "ucrania", 7056123, 6505001, 5660000, 4950001, 3028450),
	   (17, 18, "turquia", 77880103, 55250060, 46006000, 35705200, 24120000),
	   (18, 15, " marruecos", 71956123, 60066001, 55500000, 49500101, 30207050),
	   (19, 18, "china",37540000, 25345000, 18378000, 6443000,3000000),
	   (20, 16, "japon",25000000, 20000000,15000000,10000000,7000000);




INSERT INTO equipo (id, nombre, abreviatura, url, id_entrenador, id_liga, id_estadio)
VALUES
(1, "Real Madrid", "RM", "https://acortar.link/MPgQ58", 10, 1, 14),
(2, "Barcelona", "FCB",  "https://acortar.link/EYTdDr", 3, 1, 1),
(3, "Arsenal", "ARS", "https://acortar.link/yCsgXD", 8, 4, 2),
(4, "Bayern Munich", "FCB", "https://acortar.link/Ktq4SM", 9, 3, 3),
(5, "Sevilla", "SFC", "https://acortar.link/Ktq4SM", 1, 6, 6),
(6, "Rayo Cayetano", "RC", "https://acortar.link/Qyfq8S", 7, 13, 1),
(7, "Inazuma Japón", "IJ", "https://acortar.link/pQ9ja5", 18, 20, 4),
(8, "Vodka Juniors", "VJ", "https://acortar.link/tr505W", 4, 12, 5),
(9, "Welebragas FC", "WFC", "https://acortar.link/hYHcER", 5, 6, 9),
(10, "Recreativo de Juerga", "RJ", "https://acortar.link/GRJVJd", 7, 1, 7),
(11, "Nottingham Prisa", "NP", "https://acortar.link/0GT8He", 11, 14, 8),
(12, "Schalke Temeto", "SC", "https://acortar.link/nhcTFK", 19, 8, 13),
(13, "Estrella Droga", "ED", "https://acortar.link/4eXbNI", 16, 19, 10),
(14, "Real Suciedad", "RSD", "https://acortar.link/Xi6X9n", 17, 10, 11),
(15, "Sara Goza", "ZGZ", "https://acortar.link/4HaYod", 15, 13, 12),
(16, "al betis balonpie", "RBB", "https://acortar.link/nkIkBb", 6, 1, 7),
(17, "Atletico de Madrid", "ATM", "https://acortar.link/nkIkBb", 12, 1, 9),
(18, "AC Milan", "ACM", "https://acortar.link/nkIkBb", 20, 2, 20),
(19, "Paris Saint-Germain", "PSG", "https://acortar.link/nkIkBb", 14, 9, 18),
(20, "Manchester City", "MCI", "https://acortar.link/nkIkBb", 2, 4, 9);



insert into jugador (nombre , apellidos, nacionalidad, posicion,id_equipo)
values
("Lucas", "Ocampos", "Argentina", "ED",1),
("Jesús", "Navas", "España", "LD",2),
("Marcos", "Acuña", "Argentina", "LI",3),
("Jude", "Bellingham", "Inglaterra", "MCO",4),
("Sergio", "Ramos", "España", "DFC",5),
("Hector", "Bellerin", "España", "LD",6),
("Borja", "Iglesias", "España", "DC",7),
("Aitor", "Ruibal", "España", "ED",8),
("Nabil", "Fekir", "Francia", "MCO", 9),
("Marc", "Roca", "España", "MC",10),
("Thomas", "Lemar", "Francia", "LD",11),
("Sotelo", "Hugo", "España", "MC",12),
("Jude", "Sharp", "Rusia", "MCO",13),
("Axel", "Blaze", "Japón", "DFC",14),
("Nathan", "Swift", "Austria", "LD",15),
("Oliver","Aton","Japon","LD",16),
("Mark", "Evans", "Japon", "PT",17),
("Cristiano", "Ronaldo", "España", "DL",18),
("Joaquin", "Sanchez", "España", "DF",19),
("Lionel", "Messi", "Argentina", "DL",20);

select * from jugador j;