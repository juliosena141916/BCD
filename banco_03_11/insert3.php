<?php

$nome = $_POST['nome'];
$idade = $_POST['idade'];
$endereco = $_POST['endereco'];

$conn = new mysqli('localhost', 'root', 'senaisp', 'banco');

if ($conn->connect_error) {
    die("Conexão falhou: " . $conn->connect_error);
}

$sql = "INSERT INTO usuarios (nome, idade, endereco) VALUES ('$nome', '$idade', '$endereco')";

if ($conn->query($sql) === TRUE) {
    echo "Dados inseridos com sucesso!";
} else {
    echo "Erro ao inserir dados: " . $conn->error;
};

exit;

$conn->close();
