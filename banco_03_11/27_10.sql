create database banco;
use banco;

create table usuarios(
id int primary key auto_increment not null,
nome varchar(100),
idade int(3),
endereco varchar(100)
);

create table conta(
id int primary key auto_increment not null,
valor decimal(9,2)
);
 
select * from usuarios;