<?php

$conn = new mysqli("localhost", "root", "senaisp", "banco");

$id = $_GET['id'];
$result = $conn->query("SELECT * FROM usuarios where id = $id");
$row = $result->fetch_assoc();
?>

<form action="atualizar3.php" method="POST">
    <Input type="hidden" name="id" value="<?php echo $row['id'];?>">
        Nome:   <Input type="text" name="nome" value="<?php echo $row['nome'];?>"><br>
        Idade:  <Input type="number" name="idade" value="<?php echo $row['idade'];?>"><br>
        Endereço:  <Input type="text" name="endereco" value="<?php echo $row['endereco'];?>"><br>
    <Input type="submit" value="Atualizar">
</form>