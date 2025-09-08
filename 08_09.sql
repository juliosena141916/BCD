create database RemoteRC;
use RemoteRC;
select database();

create table Produto (
codigo int not null,
unidade char(3) not null,
descricao varchar(30) not null,
valor_unit decimal(7,2) not null,
primary key (codigo)
);

insert into produto values (1, 50, "Suco de Laranja", 12.00);
insert into produto values (2, 89, "Morangos", 15.00);
insert into produto values (3, 14, "KitKat", 9.00);

select * from produto;

#atualização de valores

update produto
set valor_unit = 16.00
where descricao = "morangos";

update produto
set valor_unit = 10.00,
descricao = "Suco de Maracuja"
where codigo = 1;

select * from produto;

update produto set valor_unit = valor_unit + (valor_unit * 0.10);

create table vendedores (
codigo int not null,
nome varchar(30) not null,
salario decimal(7,2) not null,
fsalarial decimal(7,2) not null,
primary key(codigo)
);

insert into vendedores values (1,"Gerson",2000,1);
insert into vendedores values (2,"Claudia",3100,2);
insert into vendedores values (3,"Pedro",5000,3);

update vendedores set salario = 3150.00 where fsalarial = 1;
update vendedores set salario = salario * 1.10 where fsalarial = 2;
update vendedores set salario = 3500.00 where fsalarial = 3;

select * from vendedores;