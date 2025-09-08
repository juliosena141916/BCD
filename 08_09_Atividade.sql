create database Biblioteca;
use Biblioteca;
select database();

create table Cliente(
id int not null,
nome varchar(50),
email varchar(50),
emprestimo boolean
);

create table Livro(
id_livro int not null,
nome_livro varchar(255),
stats boolean
);

insert into cliente values (1, "Roberta", "roberta@gmail.com", true);
insert into cliente values (2, "Valdeci", "valdeci@gmail.com", false);

select * from cliente;

insert into livro values (1, "Mistborn", false);
insert into livro values (2, "Chapeuzinho Vermelho", true);

select * from livro;

update cliente
set emprestimo = false
where id = 1;

update livro
set stats = true
where nome_livro = "Mistborn";

select * from cliente;
select * from livro;

truncate table cliente;
truncate table livro;