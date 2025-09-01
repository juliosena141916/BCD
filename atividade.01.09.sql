CREATE DATABASE atividade_aula03;
USE atividade_aula03;

create table Fornecedor (
Fcodigo int auto_increment primary key,
Fnome varchar(50),
stats varchar(100) default("Ativo"),  
Cidade varchar(50)
);

create table Peca (
Pcodigo int auto_increment primary key,
Pnome varchar(50) not null,
Cor varchar(20) not null,
Peso decimal(5,2) not null,
Cidade varchar(50) not null
);

create table Instituicao (
Icodigo int auto_increment primary key,
nome varchar(100)
);

create table Projeto (
PRcodigo int auto_increment primary key,
PRnome varchar(50),
Cidade varchar(50),
Icodigo int not null,
foreign key (Icodigo)
references Instituicao(Icodigo)
);

create table Fornecimento (
Fcodigo int not null,
foreign key (Fcodigo)
references Fornecedor(Fcodigo),
Pcodigo int not null,
foreign key (Pcodigo)
references Peca(Pcodigo),
PRcodigo int not null,
foreign key (PRcodigo)
references Projeto(PRcodigo),
Quantidade int
);

create table Cidade(
Ccodigo int auto_increment primary key,
Cnome varchar(50),
uf varchar(2) default ("SP")
);

alter table Fornecedor
add fone int(20),
add Ccodigo int not null;

alter table Fornecedor
add foreign key (Ccodigo)
references Cidade (Ccodigo);

alter table Peca
add Ccodigo int not null;

alter table Peca
add foreign key (Ccodigo)
references Cidade (Ccodigo);

alter table Projeto
add Ccodigo int not null;

alter table Projeto
add foreign key (Ccodigo)
references Cidade (Ccodigo);



