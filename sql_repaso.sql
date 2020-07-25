--Repaso
--PRIMERA PARTE
USE master;
go
DROP DATABASE Control_de_libros_BA181927_GM181938;
go

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
	2000,
	'ED02'
),
(
	'LB02',
	'SQL Server 2005',
	'345-678-076',
	'Explicación de las consultas SQL',
	'156 paginas',
	2005,
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
	2005,
	'ED01'
),
(
	'LB05',
	'SQL Server 2008',
	'789-255-481',
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
('LB01','Estante 1','Disponible'),
('LB05','Estante 5','Disponible'),
('LB06','Estante 5','Prestado'),
('LB06','Estante 5','Disponible');
go

create table autor(
codigo varchar(4) primary key,
nombres varchar(200) not null,
apellidos varchar(200) not null,
nacionalidad varchar(200) not null
);
go

insert into autor (codigo, nombres, apellidos,nacionalidad) values
('AU01','JOSE PEDRO','ALVARADO','ESPAÑOLA'),
('AU02','MARIA TERESA', 'RIVAS','MEXICANO'),
('AU03','JULIO CARLOS','FERNANDEZ','COLOMBIANO'),
('AU04','ALEXANDER','RODRIGEZ','MEXICANO'),
('AU05','JUAN MANUEL','ARTIAGA','COLOMBIANO');

go


create table autor_libro(
cod_libro varchar(4) not null,
cod_autor varchar (4) not null,
	constraint fk_cod_libro_libro foreign key (cod_libro) 
	references libro(codigo),

	constraint fk_cod_autor_autor foreign key (cod_autor) 
	references autor(codigo)
);
go
insert into autor_libro (cod_libro,cod_autor) values 
('LB01','AU02'),('LB01','AU04'),
('LB02','AU01'),('LB03','AU05'),
('LB03','AU03'),('LB04','AU02'),
('LB04','AU04');
go
--SEGUNDA PARTE
--A
select a.*, l.titulo
from autor a 
inner join autor_libro al on a.codigo =al.cod_autor
inner join libro l on al.cod_libro = l.codigo
order by a.nombres desc

go
--B
select distinct a.*,e.nombres as 'Nombre editorial' from autor a
inner join autor_libro al on a.codigo =al.cod_autor
inner join libro l on al.cod_libro = l.codigo
inner join editorial e on e.codigo = 'ED02'
order by a.nombres asc
--C
go
--C
select l.titulo,
	(select count (*) from ejemplar e where e.cod_libro = l.codigo) 
	as ejemplares
from libro l order by ejemplares desc 
go
--D
select distinct l.titulo from libro l
inner join ejemplar e on e.cod_libro = l.codigo
where e.estado = 'Prestado'
go
--E
select * from libro l
where l.anio_edicion between 2000 and 2007
order by l.anio_edicion asc
go

--F
select e.ubicacion, COUNT (e.cod_libro)
	as 'Numero libros'	
	from ejemplar e
	where e.estado = 'prestado'
group by e.ubicacion
go 

--TERCERA PARTE
--A
create table autores_espana(
codigo varchar(4) primary key,
nombres varchar(200) not null,
apellidos varchar(200) not null
);
go

--Autores que se transferiran de tabla
select * from autor where nacionalidad='Española';
go

--Transferencia de autores de nacionalidad española
INSERT INTO autores_espana (codigo,nombres,apellidos)
Select codigo, nombres, apellidos
FROM autor WHERE nacionalidad='Española';
go

--Comprobación de traspaso
Select * from autores_espana;
go

--B)
USE library;
go
--Creamos la vista
create view copia_libro as
Select cp.isbn, cp.copy_no, cp.on_loan, tl.title, it.translation, it.cover 
from copy cp, title tl, item it
where (cp.isbn='1') OR (cp.isbn='500') OR (cp.isbn='1000');

--Revisamos y ordenamos la vista
select * from copia_libro
order by isbn;