-- Geração de Modelo físico
-- Sql ANSI 2003 - brModelo.

create database Livraria;
use Livraria;
select database();


CREATE TABLE Autores (
cod_autor int primary key auto_increment not null,
nome varchar(100),
data_nascimento datetime,
nacionalidade varchar(50)
);

CREATE TABLE Editoras (
cod_editora int primary key auto_increment not null,
cnpj varchar(20),
contato varchar(100),
cidade varchar(100),
endereco varchar(255),
telefone varchar(18),
nome_editora varchar(100)
);

CREATE TABLE Clientes (
cod_cliente int primary key auto_increment not null,
telefone varchar(18),
nome_cliente varchar(100),
data_nascimento datetime,
email varchar(255),
cpf varchar(15)
);

CREATE TABLE Livros (
cod_livro int primary key auto_increment not null,
preco decimal(5,2),
titulo varchar(255),
quantidade int(5),
genero varchar(50),
cod_autor int,
cod_editora int,
FOREIGN KEY(cod_autor) REFERENCES Autores (cod_autor),
FOREIGN KEY(cod_editora) REFERENCES Editoras (cod_editora)
);

CREATE TABLE vendas (
cod_vendas int primary key auto_increment not null,
cod_livro int,
cod_cliente int,
valor_total decimal(8,2),
data_venda datetime,
FOREIGN KEY(cod_livro) REFERENCES Livros (cod_livro),
FOREIGN KEY(cod_cliente) REFERENCES Clientes (cod_cliente)
);