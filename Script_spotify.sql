DROP TABLE IF EXISTS reproduccion;
DROP TABLE IF EXISTS usuario;
DROP TABLE IF EXISTS registro_auditoria;
DROP TABLE IF EXISTS cancion_historico;
DROP TABLE IF EXISTS cancion;
DROP TABLE IF EXISTS album;
DROP TABLE IF EXISTS artista;




CREATE TABLE artista(
  id int(10) NOT NULL AUTO_INCREMENT,
  nombre_completo varchar(150) NOT NULL,
  apodo varchar(30) NOT NULL,
  pais varchar(20) NOT NULL,
  fecha_nacimiento date NOT NULL,
  PRIMARY KEY (id)
);/*bien*/

CREATE TABLE album (
  id int(10) NOT NULL AUTO_INCREMENT,
  titulo varchar(150) NOT NULL,
  fecha_lanzamiento date NOT NULL,
  id_artista int(10) NOT NULL,
  duracion_total time NOT NULL DEFAULT '00:00:00',
  PRIMARY KEY (id),
  KEY fk_album_artista (id_artista)
);/*bien*/

CREATE TABLE cancion(
  id int(10) NOT NULL AUTO_INCREMENT,
  titulo varchar(150) NOT NULL,
  duracion time NOT NULL,
  id_album int(10) NOT NULL,
  num_reproducciones int(10) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY fk_cancion_album (id_album),
  CONSTRAINT fk_cancion_album FOREIGN KEY (id_album) REFERENCES album(id)
);/*bien, pero antes estaba debajo de cancion_historico*/

CREATE TABLE cancion_historico( /*mal orden, la tabla canción va antes*/
  id int(10) NOT NULL AUTO_INCREMENT,
  id_cancion int(10) DEFAULT NULL,
  antigua_duracion time(2) DEFAULT NULL,
  fecha_cambio datetime DEFAULT NULL,
  PRIMARY KEY (id),
  KEY fk_cancion_historico_cancion(id_cancion),/*cuidado*/
  CONSTRAINT fk_cancion_historico_cancion FOREIGN KEY (id_cancion) REFERENCES cancion(id)
);

CREATE TABLE usuario (
  id int(10) NOT NULL AUTO_INCREMENT,
  nombre_completo varchar(150) NOT NULL,
  pais varchar(150) NOT NULL,
  PRIMARY KEY (id)
);/*bien, pero antes estaba debajo de la tabla registro_auditoria*/

CREATE TABLE registro_auditoria (/*mal orden, la tabla usuario va arriba*/
  id int(10) NOT NULL AUTO_INCREMENT,
  id_cancion int(10) NOT NULL,
  id_usuario int(10) NOT null,/*falta una coma*/
  fecha_reproduccion date NOT NULL, /*los date no lleva paréntesis ni nada*/ /*(5)*/
  PRIMARY KEY (id),
  KEY fk_registro_cancion (id_cancion),
  KEY fk_registro_usuario (id_usuario),
  CONSTRAINT fk_registro_cancion FOREIGN KEY (id_cancion) REFERENCES cancion (id), /*le faltan los paréntesis*/
  CONSTRAINT fk_registro_usuario FOREIGN KEY (id_usuario) REFERENCES usuario (id) /*le faltan los paréntesis*/
);

CREATE TABLE reproduccion (
  id_usuario int(10) NOT NULL,
  id_cancion int(10) NOT null, /*falta una coma*/
  fecha_reproduccion year(4) NOT NULL,
  KEY fk_reproduccion_cancion (id_usuario),
  KEY fk_reproduccion_usuario (id_cancion),/*falta una coma*/
  CONSTRAINT fk_reproduccion_cancion FOREIGN KEY (id_usuario) REFERENCES usuario (id),
  CONSTRAINT fk_reproduccion_usuario FOREIGN KEY (id_cancion) REFERENCES cancion (id)
);






INSERT INTO artista 
VALUES 
(1,'Benito Antonio Martínez','Bad Bunny','Puerto Rico','1994/04/10'),
(2,'Pedro Luis Domínguez Quevedo','Quevedo','España','2001/12/07'),
(3,'Manuel Turizo Zapata','Manuel Turizo','Colombia','2000/04/12'),
(4,'Juan Luis Morera y Llandel Veguilla ','Wissin y Yandel','Puerto Rico','1978/12/19'),
(5,'Shakira Isabel Mebarak Ripoll','Shakira','Colombia','1977/02/02'),
(6,'Carolina Giraldo Navarro','Karol G','Colombia','1991/02/14');

INSERT INTO cancion /*faltan los id_artista*/
VALUES 
(1,1,'PLaya del Inglés','04:20:00',1.9),/*los decimales se ponen con . no con ,*/
(2,2,'Ahora Qué','02:51:00',1.0),
(3,3,'Punto G','02:31:00',1.0),
(4,4,'Wanda','02:41:00',1.0),
(5,5,'Moscow Mule','04:05:00',2.0),
(6,6,'Me Porto Bonito','02:58:00',2.0),
(7,1,'Tití Me Preguntó','04:03:00',2.0),
(8,2,'Tarot','03:53:00',2.0),
(9,3,'Ojitos Lindos','04:18:00',2.0),
(10,4,'Dakiti','03:25:00',3.0),
(11,5,'La noche de anoche','03:33:00',3.0),
(12,6,'La Bachata','03:06:00',4.0),
(13,1,'Bzrp Music Sessions, Vol.53','03:37:00',5.0),
(14,2,'Besos Moja2','03:49:00',6.0),
(15,3,'Provenza','03:49:00',7.0),/*falta una coma*/
(16,4,'Recordar','20:00:00',6.0),
(17,5,'Wanda','03:45:00',1.0);


INSERT INTO registro_auditoria 
VALUES 
(1,1,7,'2023-05-16'),
(2,2,5,'2023-05-16'),
(3,3,7,'2023-05-16'),
(4,3,3,'2023-05-16'),
(8,1,8,'2023-05-16'),
(9,1,4,'2023-05-16'),
(11,1,2,'2023-05-16'); /*mal orden, debe de estar debajo de canción*/

INSERT INTO album 
VALUES 
(1,'DONDE QUIERO ESTAR','2023-05-16',2,'73:23:00'),
(2,'Un verano sin ti','2022-05-06',1,'00:00:00'),
(3,'EL último tour del mundo','2020-11-27',1,'00:00:00'),/*falta una coma*/
(4,'Singles','2022-05-26',3,'00:00:00'),
(5,'Sesiones Bzrp','2023-01-11',5,'00:00:00'),
(6,'La Ultima Misión','2022-12-01',4,'00:00:00'),
(7,'PROVENZA','2022-04-22',4,'00:00:00');



INSERT INTO cancion_historico 
VALUES 
(1,1,'03:58:00','2023-05-10 00:00:00'),
(2,1,'04:20:00','2023-05-16 00:00:00'),
(4,34,'04:20:00','2023-05-16 00:00:00');

INSERT INTO usuario 
VALUES 
(1,'Paco','España'),
(2,'Antonio','España'),
(3,'Jesús','España'),
(4,'Ainhoa','España'),
(5,'Clara','España'),
(6,'Enrique','España'),
(7,'John','UK'),
(8,'Kevin','UK'),
(9,'Penny','UK'),
(10,'Mika','UK'),
(11,'Kennedy ','UK'),
(12,'Gines','DESCONOCIDO');/*bien*/

INSERT INTO reproduccion 
VALUES 
(1,1,2023),
(2,1,2023),
(3,1,2023),
(8,1,2023),
(7,1,2023),
(10,2,2023),
(7,2,2023),
(2,2,2023),
(2,2,2023),
(1,3,2023),
(2,3,2023),
(7,3,2023),
(8,3,2023),
(7,3,2023),
(6,3,2023),
(10,5,2022),
(1,5,2022),
(3,5,2022),
(4,5,2022),
(7,5,2022),
(7,6,2022),
(7,6,2022),
(5,6,2022),/*falta coma*/
(5,7,2022),
(7,7,2022),
(5,7,2022),
(10,7,2022),
(1,7,2022),
(5,8,2022),
(7,8,2022),
(4,8,2022),
(3,8,2022),
(1,8,2022),
(4,9,2022),/*falta coma*/
(3,9,2022),
(1,9,2022),
(4,10,2022),
(3,10,2022),/*falta coma*/
(1,10,2022),
(9,11,2023),
(9,11,2023),
(9,11,2023),
(9,11,2023),
(8,12,2023),/*falta coma*/
(8,12,2023),
(8,12,2023),
(8,12,2023),
(1,13,2023),
(1,13,2023),
(1,13,2023),
(1,13,2023),
(5,14,2023),
(4,14,2023),
(3,14,2023),
(2,14,2023),/*falta una coma*/
(1,1,2023),
(1,2,2023),
(1,3,2023),
(3,3,2023),
(1,1,2023),
(1,1,2023),
(1,1,2023);
/*falta el ;*/