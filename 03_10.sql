create database aula;
use aula;

CREATE TABLE Alunos (
id int primary key auto_increment not null,
nome varchar(100),
email varchar(100) not null,
data_nascimento date
);

create table cursos(
id int primary key auto_increment not null,
titulo varchar(100),
descricao varchar(100),
carga_horaria int(4),
status varchar(15) default "ativo"
);

create table inscricoes(
id int primary key auto_increment not null,
aluno_id int,
curso_id int,
foreign key (aluno_id) references alunos(id),
foreign key (curso_id) references cursos(id),
data_inscricao date
);

create table avaliacoes(
id int primary key auto_increment not null,
inscricao_id int,
nota decimal(4,2),
comentario varchar(100),
foreign key (inscricao_id) references inscricoes(id)
);

create table aluno_inscricao(
aluno_inscricao_id int primary key auto_increment not null,
aluno_id int,
inscricao_id int,
foreign key (aluno_id) references alunos(id),
foreign key (inscricao_id) references inscricoes(id)
);

create table curso_inscricao(
curso_inscricao_id int primary key auto_increment not null,
curso_id int,
inscricao_id int,
foreign key (curso_id) references cursos(id),
foreign key (inscricao_id) references inscricoes(id)
);

insert into alunos values
(0,"Marcos","marcos@gmail.com",'2000-12-21'),
(0,"Cleiton","cleiton@gmail.com",'1980-01-11'),
(0,"Marcelle","marcelle@gmail.com",'2001-06-07'),
(0,"Carla","carla@gmail.com",'1969-09-19'),
(0,"Adalberto","adalberto@gmail.com",'1950-10-03');

insert into cursos values
(0,'Matemática Avançada', 'Curso avançado de Matemática', 120, 'ativo'),
(0,'História da Arte', 'Estudo da história da arte mundial', 90, 'ativo'),
(0,'Programação em Python', 'Curso básico de programação em Python', 80, 'ativo'),
(0,'Gestão de Projetos', 'Introdução à gestão de projetos corporativos', 100, 'ativo'),
(0,'Fotografia Digital', 'Técnicas e práticas de fotografia digital', 60, 'inativo');

INSERT INTO inscricoes VALUES
(0,1, 1, '2023-09-10'),
(0,2, 2, '2023-09-12'),
(0,3, 3, '2023-09-15'),
(0,4, 4, '2023-09-17'),
(0,5, 1, '2023-09-20');

INSERT INTO avaliacoes VALUES
(0,1,9.50, 'Curso excelente, aprendi muito!'),
(0,2,8.75, 'Bom conteúdo, mas poderia ser mais aprofundado.'),
(0,3,7.00, 'Curso interessante, mas com muito material teórico.');

update alunos
set email = "marco@gmail.com"
where nome = "Marcos";

update cursos
set carga_horaria = 120
where id = 4;

update alunos
set nome = "marco"
where nome = "Marcos";

update cursos
set status = "inativo"
where id = 3;
