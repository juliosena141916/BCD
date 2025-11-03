<?php
$conn = new mysqli("localhost", "root", "senaisp", "banco");

$id = $_POST['id'];
$nome = $_POST['nome'];
$idade = $_POST['idade'];
$endereco = $_POST['endereco'];

$sql = "UPDATE usuarios SET nome='$nome', idade='$idade', endereco='$endereco' where id=$id";

if ($conn->query($sql) === TRUE){
    echo "Dados atualizados com sucesso!";
    echo "<br><a href='index\A-+..html'>voltar<a>";
} else {
    echo "Erro: " . $conn->error;
}

$conn->close();
?>