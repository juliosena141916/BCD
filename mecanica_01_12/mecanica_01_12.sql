Create database mecanica;
use mecanica;

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
placa varchar(10),
id_cliente_FK int,
foreign key (id_cliente_FK) references clientes(id_cliente)
);

Create table Ordem_servico(
id_ords int primary key auto_increment,
id_veiculo_FK int,
id_material_FK int,
id_serv_FK int,
id_mec_FK int,
foreign key (id_veiculo_FK) references Veiculos(id_veiculo),
foreign key (id_material_FK) references Materiais(id_material),
foreign key (id_serv_FK) references Servico(id_serv),
foreign key (id_mec_FK) references Mecanicos(id_mec)
);

CREATE TABLE OS_Pecas (
    id_os_peca INT PRIMARY KEY AUTO_INCREMENT,
    id_ords_FK INT,
    id_material_FK INT,
    quantidade_usada INT,
    FOREIGN KEY (id_ords_FK) REFERENCES Ordem_servico(id_ords),
    FOREIGN KEY (id_material_FK) REFERENCES Materiais(id_material)
);

CREATE TABLE OS_Mecanicos (
    id_os_mec INT PRIMARY KEY AUTO_INCREMENT,
    id_ords_FK INT,
    id_mec_FK INT,
    FOREIGN KEY (id_ords_FK) REFERENCES Ordem_servico(id_ords),
    FOREIGN KEY (id_mec_FK) REFERENCES Mecanicos(id_mec)
);

CREATE TABLE OS_Servicos (
    id_os_serv INT PRIMARY KEY AUTO_INCREMENT,
    id_ords_FK INT NOT NULL,
    id_serv_FK INT NOT NULL,
    FOREIGN KEY (id_ords_FK) REFERENCES Ordem_servico(id_ords),
    FOREIGN KEY (id_serv_FK) REFERENCES Servico(id_serv)
);



-- SELECT --

SELECT * FROM Veiculos
WHERE modelo = 'Ford';

SELECT nome
FROM Clientes
JOIN Veiculos ON id_cliente_FK = id_cliente
JOIN Ordem_servico ON id_veiculo_FK = id_veiculo
WHERE data_criacao >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);

select * from mecanicos
where especialidade = "Injeção Eletronica";

select * from Ordem_servico
where status = "aberto";

select * from materiais
where estoque < 5;

SELECT v.id_veiculo, v.modelo, v.cor, v.placa
FROM Veiculos v
WHERE (
        SELECT COUNT(*)
        FROM Ordem_servico os
        WHERE os.id_veiculo_FK = v.id_veiculo
      ) > 1;

select * from Ordem_servico
where id_mec_fk = 3;



-- UPDATE --

UPDATE Materiais
SET preco_venda = preco_venda * 1.05
WHERE fabricante = 'Bosch';

UPDATE Ordem_servico
SET status = 'Concluída'
WHERE id_ords = 105 AND status = 'Em Execução';

UPDATE Ordem_servico
SET data_conclusao = CURDATE()
WHERE status = 'Em Execução' AND data_abertura < DATE_SUB(CURDATE(), INTERVAL 30 DAY);

UPDATE Materiais
SET quantidade = quantidade * 2
WHERE id_material = 20;


-- ALTER TABLE --

ALTER TABLE Clientes
ADD email VARCHAR(100);

ALTER TABLE Mecanicos
MODIFY COLUMN especialidade VARCHAR(150);

ALTER TABLE Ordem_servico
DROP COLUMN diagnostico_entrada;

ALTER TABLE Materiais
ADD CONSTRAINT chk_preco_venda
CHECK (preco_venda >= valor);

-- JOIN --

SELECT nome AS cliente,
       placa AS veiculo,
       data_criacao
FROM Ordem_servico os
JOIN Veiculos ON id_veiculo_FK = id_veiculo
JOIN Clientes ON id_cliente_FK = id_cliente;

SELECT nome_material, quantidade_usada
FROM OS_Pecas
JOIN Materiais ON id_material_FK = id_material
WHERE id_ords_FK = 50;

SELECT nome
FROM OS_Mecanicos
JOIN Mecanicos ON id_mec_FK = id_mec
WHERE id_ords_FK = 75;

SELECT placa, modelo, nome AS proprietario
FROM Veiculos
JOIN Clientes ON id_cliente_FK = id_cliente;

-- INNER JOIN --

SELECT placa, modelo
FROM Veiculos
JOIN Ordem_servico ON id_veiculo_FK = id_veiculo
WHERE status = 'Em Execução';

SELECT DISTINCT nome AS cliente
FROM Clientes
JOIN Veiculos ON id_cliente_FK = id_cliente
WHERE modelo = 'Volkswagen';

SELECT DISTINCT nome
FROM Mecanicos
JOIN OS_Mecanicos ON id_mec = id_mec_FK;

SELECT DISTINCT nome_serv
FROM Servico
JOIN OS_Servicos ON id_serv = id_serv_FK;

-- LEFT JOIN --

SELECT id_cliente, nome, GROUP_CONCAT(id_ords) AS ids_ordens
FROM clientes
LEFT JOIN Veiculos ON id_cliente = id_cliente_FK
LEFT JOIN Ordem_servico ON id_veiculo = id_veiculo_FK
GROUP BY id_cliente, nome;

SELECT id_mec, nome, COUNT(id_ords_FK) AS total_ordens
FROM Mecanicos
LEFT JOIN OS_Mecanicos osm ON id_mec = id_mec_FK
GROUP BY id_mec, nome;

SELECT id_material, nome_material, SUM(quantidade_usada) AS total_vendida
FROM Materiais
LEFT JOIN OS_Pecas op ON id_material = id_material_FK
GROUP BY id_material, nome_material;

SELECT id_veiculo, modelo, placa, MAX(data_abertura) AS ultima_os
FROM Veiculos
LEFT JOIN Ordem_servico o ON id_veiculo = id_veiculo_FK
GROUP BY id_veiculo, modelo, placa;

-- RIGHT JOIN --

SELECT id_ords, nome
FROM Ordem_servico
RIGHT JOIN Veiculos ON id_veiculo = id_veiculo_FK
RIGHT JOIN clientes ON id_cliente = id_cliente_FK;

SELECT id_serv, nome_serv, GROUP_CONCAT(id_ords_FK) AS ids_os
FROM Servico
RIGHT JOIN OS_Servicos ON id_serv = id_serv_FK
GROUP BY id_serv, nome_serv;

SELECT id_os_mec, id_ords_FK, id_mec_FK, nome
FROM OS_Mecanicos 
RIGHT JOIN Mecanicos ON id_mec_FK = id_mec;

SELECT id_ords, id_veiculo_FK, modelo, placa
FROM Ordem_servico
RIGHT JOIN Veiculos ON id_veiculo_FK = id_veiculo;

-- SUBCONSUTAS --

SELECT id_cliente, nome, total_os
FROM (
    SELECT c.id_cliente, c.nome, COUNT(o.id_ords) AS total_os
    FROM clientes c
    LEFT JOIN Veiculos v ON c.id_cliente = v.id_cliente_FK
    LEFT JOIN Ordem_servico o ON v.id_veiculo = o.id_veiculo_FK
    GROUP BY c.id_cliente, c.nome
) AS sub
WHERE total_os > 3;


SELECT nome_material
FROM Materiais
WHERE id_material IN (
    SELECT id_material_FK
    FROM OS_Pecas
    WHERE id_ords_FK IN (
        SELECT id_ords_FK
        FROM OS_Mecanicos
        WHERE id_mec_FK = 4
    )
);

SELECT placa, modelo
FROM Veiculos
WHERE id_veiculo NOT IN (
    SELECT id_veiculo_FK
    FROM Ordem_servico
);

SELECT nome_serv, preco
FROM Servico
WHERE preco > (
    SELECT AVG(preco)
    FROM Servico
);

-- AGREGAÇÃO --

SELECT 
    o.id_ords,
    SUM(s.preco) + SUM(m.valor * op.quantidade_usada) AS faturamento_total
FROM Ordem_servico o
LEFT JOIN OS_Servicos os ON o.id_ords = os.id_ords_FK
LEFT JOIN Servico s ON os.id_serv_FK = s.id_serv
LEFT JOIN OS_Pecas op ON o.id_ords = op.id_ords_FK
LEFT JOIN Materiais m ON op.id_material_FK = m.id_material
WHERE o.id_ords = 100
GROUP BY o.id_ords;

SELECT AVG(DATEDIFF(data_conclusao, data_criacao)) AS tempo_medio_aberto
FROM Ordem_servico
WHERE data_conclusao IS NOT NULL AND data_criacao IS NOT NULL;

-- AGREGACAO SIMPLES --

SELECT COUNT(id_veiculo) AS total_veiculos
FROM Veiculos;

SELECT SUM(quantidade * valor) AS valor_total_estoque
FROM Materiais;

SELECT AVG(preco) AS preco_medio_mao_obra
FROM Servico;

-- AGREGACAO AGRUPAMENTO --

SELECT marca, COUNT(id_veiculo) AS total_veiculos
FROM Veiculos
GROUP BY marca;

SELECT MONTH(data_abertura) AS mes, COUNT(id_ords) AS total_os
FROM Ordem_servico
GROUP BY MONTH(data_abertura);

SELECT status, COUNT(id_ords) AS total_os
FROM Ordem_servico
GROUP BY status;

-- AGREGACAO FILTROS --

SELECT COUNT(id_ords) AS total_os_concluidas
FROM Ordem_servico
WHERE status = 'Concluído';

SELECT 
    SUM(s.preco) + SUM(m.valor * op.quantidade_usada) AS faturamento_total
FROM Veiculos v
LEFT JOIN Ordem_servico o ON v.id_veiculo = o.id_veiculo_FK
LEFT JOIN OS_Servicos os ON o.id_ords = os.id_ords_FK
LEFT JOIN Servico s ON os.id_serv_FK = s.id_serv
LEFT JOIN OS_Pecas op ON o.id_ords = op.id_ords_FK
LEFT JOIN Materiais m ON op.id_material_FK = m.id_material
WHERE v.marca = 'Fiat' 
AND YEAR(o.data_abertura) = YEAR(CURDATE()) - 1;

SELECT AVG(preco) AS preco_medio_motor
FROM Servico
WHERE descricao LIKE '%Motor%';

-- AGREGACAO COMPLEXA --

SELECT c.id_cliente, SUM(s.preco + m.valor * op.quantidade_usada) AS total_gasto
FROM clientes c
LEFT JOIN Veiculos v ON c.id_cliente = v.id_cliente_FK
LEFT JOIN Ordem_servico o ON v.id_veiculo = o.id_veiculo_FK
LEFT JOIN OS_Servicos os ON o.id_ords = os.id_ords_FK
LEFT JOIN Servico s ON os.id_serv_FK = s.id_serv
LEFT JOIN OS_Pecas op ON o.id_ords = op.id_ords_FK
LEFT JOIN Materiais m ON op.id_material_FK = m.id_material
GROUP BY c.id_cliente
HAVING SUM(s.preco + m.valor * op.quantidade_usada) > 5000;

SELECT id_material_FK AS id_peca, SUM(quantidade_usada) AS total_vendida
FROM OS_Pecas
GROUP BY id_material_FK
HAVING SUM(quantidade_usada) > 100;

SELECT m.especialidade, COUNT(osm.id_ords_FK) AS total_ordens
FROM Mecanicos m
INNER JOIN OS_Mecanicos osm ON m.id_mec = osm.id_mec_FK
GROUP BY m.especialidade
HAVING COUNT(osm.id_ords_FK) > 20;

SELECT m.nome, COUNT(osm.id_ords_FK) AS total_ordens
FROM Mecanicos m
INNER JOIN OS_Mecanicos osm ON m.id_mec = osm.id_mec_FK
GROUP BY m.id_mec
ORDER BY total_ordens DESC
LIMIT 1;

-- INDEXAÇÃO --	

CREATE INDEX idx_placa ON Veiculos(placa);

CREATE INDEX idx_id_veiculo ON Ordem_servico(id_veiculo);
