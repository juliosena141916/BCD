<?php

$conn = new mysqli('localhost', 'root', 'senaisp', 'banco');

if ($conn->connect_error) {
    die("Conexão falhou: " . $conn->connect_error);
}

$id = $_GET['id'];

$stmt = $conn->prepare("DELETE FROM usuarios WHERE id = ?");
$stmt->bind_param("i", $id);

if ($stmt->execute()) {
    echo "Usuario deletado com sucesso.";
} else {
    echo "Erro ao deletar registro: " . $stmt->error;
}
echo "<br><a href='listar3.php'>Voltar para a lista</a>";

$stmt->close();
$conn->close();
