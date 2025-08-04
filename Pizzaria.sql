create database Pizzaria;
use Pizzaria;

create table Cliente(
ID_Cliente int,
Endereco varchar(255),
Telefone int,
Nome varchar(255)
);

create table Administrador(
ID_Administrador int,
Nome_Adm varchar(255),
Telefone_Adm int,
Endereco_Adm varchar(255)
);

create table Funcionarios(
ID_Funcionarios int,
Funcao varchar(255),
Nome_Funcionario varchar(255),
Endereco_Funcionario varchar(255)
);

create table Pizzas(
ID_Pizzas int,
Preco float,
Ingrediente varchar(255),
Tamanho varchar(255)
);

select * from Cliente -- Consultar valores