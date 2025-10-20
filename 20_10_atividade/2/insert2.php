<?php

$telefone = $_POST['telefone'];
$nome_cliente = $_POST['nome'];
$data_nascimento = $_POST['data_nascimento'];
$email = $_POST['email'];
$cpf = $_POST['cpf'];

$conn = new mysqli('localhost', 'root', 'senaisp', 'livraria');

if ($conn->connect_error) {
    die("Conexão falhou: " . $conn->connect_error);
}

$sql = "INSERT INTO clientes (telefone, nome_cliente, data_nascimento, email, cpf) VALUES ('$telefone', '$nome_cliente', '$data_nascimento', '$email','$cpf')";

if ($conn->query($sql) === TRUE) {
    echo "Dados inseridos com sucesso!";
} else {
    echo "Erro ao inserir dados: " . $conn->error;
}

exit;
$conn->close();
?>