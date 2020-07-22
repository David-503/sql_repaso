--Repaso
USE master;

DROP DATABASE IF EXISTS Control_de_libros_BA181927_GM181938;

CREATE DATABASE Control_de_libros_BA181927_GM181938;
GO

USE  Control_de_libros_BA181927_GM181938;
GO

CREATE TABLE editorial(
codigo varchar (4) primary key,
nombres varchar (250) not null,
pais varchar (200) not null
);
GO

INSERT INTO editorial(codigo,nombres,pais) 
values
('ED01','Thomson international','España'),
('ED02','Omega','México'),
('ED03','La fuente de la sabiduria','Colombia'),
('ED04','Siglo XV','España');

go

CREATE TABLE libro(
codigo varchar(4) primary key,
titulo varchar(250) not null,
ISBN varchar(11) not null,
descripcion text not null,
resumen varchar (50) not null,
anio_edicion smallint not null,
cod_editorial varchar (4) not null, 
constraint fk_editorial foreign key (cod_editorial)
references  editorial(codigo)
);
GO

INSERT INTO libro(codigo,titulo,ISBN,descripcion,resumen,anio_edicion,cod_editorial)
values 
(
	'LB01',
	'Metodología de la programación',
	'123-334-456',
	'Sintaxis básicas de la programación',
	'204 paginas',
	200,
	'ED02'
),
(
	'LB02',
	'SQL Server 2005',
	'345-678-076',
	'Explicación de las consultas SQL',
	'156 paginas',
	1997,
	'ED03'
),
(
	'LB03',
	'Como programar en C/C++',
	'153-567-345',
	'Diferencias entre C y C++',
	'156 Paginas',
	1997,
	'ED02'
),
(
	'LB04',
	'Aprender PHP en 30 dias',
	'234-345-987',
	'Administración de bases de datos',
	'150 paginas',
	2008,
	'ED03'
),
(
	'LB06',
	'CSS Y HTML',
	'652-441-111',
	'Creación de páginas web y hojas de estilo',
	'350 paginas',
	2007,
	'ED01'
);
go
CREATE TABLE ejemplar(
	cod_libro varchar (4) not null,
	ubicacion varchar (50) not null,
	estado varchar (10)not null,
	check (estado='Disponible' or estado = 'Reservado' or estado='Prestado'),
	constraint fk_cod_libro foreign key (cod_libro) 
	references libro(codigo)

);	
go 

insert into ejemplar(cod_libro,ubicacion,estado) 
values 
('LB01','Estante 1','prestado'),
('LB02','Estante 2','Disponible'),
('LB02','Estante 2','Reservado'),
('LB03','Estante 3','Prestado'),
('LB04','Estante 4','Disponible'),
('LB02','Estante 2','Reservado'),
('LB04','Estante 4','Prestado'),
('LB01','Estante 1','Disponible'),
('LB02','Estante 2','Reservado'),
('LB03','Estante 3','Prestado'),
--('LB01','Estante 1','Disponible'),
--('LB05','Estante 5','Disponible'),
('LB06','Estante 5','Prestado'),
('LB06','Estante 5','Disponible');