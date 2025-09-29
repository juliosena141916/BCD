create database Livraria;
use Livraria;
select database();

CREATE TABLE Autores (
cod_autor int primary key auto_increment not null,
nome varchar(100),
data_nascimento varchar(12),
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
data_nascimento varchar(12),
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
data_venda varchar(12),
FOREIGN KEY(cod_livro) REFERENCES Livros (cod_livro),
FOREIGN KEY(cod_cliente) REFERENCES Clientes (cod_cliente)
);

insert into autores values (0,"Carmem","11/11/1994","Espanha"),
(0,"harry","05/05/2005","Croacia"),
(0,'João Guimarães', '10/06/1945', 'Brasileira'),
(0,'Lia Varela', '25/11/1988', 'Argentina'),
(0,'Thomas Keller', '03/01/1972', 'Alemã');

insert into editoras values(0,1111111111--11,"marcio","piracicaba","rua piracicaba","(99)99999-9999","paginini"),
(0,1111111111-11,"Brenno","Limeira","Av. campinas","(99)99999-9999","samambaia"),
(0,'3333333333-33', 'Silvia Mendes', 'Rio de Janeiro', 'Rua dos Sabias, 50', '(21)33333-3333', 'Horizonte'),
(0,'4444444444-44', 'Ricardo Alves', 'Belo Horizonte', 'Av. Afonso Pena, 1000', '(31)44444-4444', 'Estrela Guia'),
(0,'5555555555-55', 'Fernanda Lima', 'Porto Alegre', 'Travessa da Saudade, 7', '(51)55555-5555', 'Leitura Certa');

insert into clientes values (0,"(99)99999-9999","Gerson","22/02/1950","gerson@gmail.com","999.999.999-99"),
(0,"(99)99999-9999","Cleber","11/09/1980","cleber@gmail.com","999.999.999-99"),
(0,'(88)77777-7777', 'André Costa', '05/12/1990', 'andre.costa@exemplo.com', '123.456.789-00'),
(0,'(11)66666-6666', 'Beatriz Ferreira', '14/08/2001', 'bia.ferreira@exemplo.com', '098.765.432-11'),
(0,'(31)55555-5555', 'Carlos Henrique', '28/04/1965', 'carlos.h@exemplo.com', '234.567.890-22');

insert into livros values (0,52.99,"carrinhos",100,"comedia",1,1),
(0,84.52,"salamandra",21,"suspense",2,2),
(0,45.00, 'A Lenda do Sertão', 80, 'Drama', 3, 4),
(0,78.90, 'Crônicas Urbanas', 40, 'Contos', 4, 3), 
(0,95.20, 'Receitas Clássicas', 30, 'Culinária', 5, 5);

insert into vendas values (0,1,1,100.00,"30/12/2024"),
(0, 2, 2, 999.99,"14/11/2005"),
(0,3, 4, 45.00, '05/01/2025'),
(0,4, 3, 157.80, '10/02/2025'),
(0,5, 5, 95.20, '20/03/2025');

select titulo,quantidade from livros
order by quantidade desc;

select * from livros
where titulo like 'S%' and preco > 80.00;

select sum(preco) as total_livros
from livros;

select sum(quantidade) as estoque
from livros;

delete from livros
where cod_livro = 5;

alter table livros
add column ano_publicacao date;