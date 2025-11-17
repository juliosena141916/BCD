Create table clientes(
id_cliente int primary key auto_increment,
nome varchar(100),
telefone int(11),
CEP varchar(9)
);

Create table Mecanicos(
id_mec int primary key auto_increment,
nome varchar(100),
telefone int(12),
endereco varchar(255)
);

Create table Materiais(
id_material int primary key auto_increment,
valor decimal(5,2),
quantidade int(5),
nome_material varchar(100)
);

Create table Servico(
id_serv int primary key auto_increment,
nome_serv varchar(100),
descricao varchar(100),
preco decimal(5,2)
);

Create table Veiculos(
id_veiculo int primary key auto_increment,
modelo varchar(50),
cor varchar(20),
placa varchar(10)
);

Create table Ordem_servico(
id_ords int primary key auto_increment,
id_veiculo_FK int,
id_material_FK int,
id_serv_FK int,
id_mec_FK int,
foreign key (id_veiculo_FK) references Veiculos(id_veiculo),
foreign key (id_material_FK) references Materiais(id_material),
foreign key (id_serv_FK) references Servicos(id_serv),
foreign key (id_mec_FK) references Mecanicos(id_mec)
);