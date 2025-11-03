<?php

$conn = new mysqli("localhost", "root", "senaisp", "banco");
$result = $conn->query("SELECT * FROM usuarios");

echo "<h2>Usuarios</h2>";
echo "<table border='1'>";
echo "<tr><th>ID</th><th>Nome</th><th>Idade</th><th>Endereço</th><th>Ações</th><th>Deletar</th></tr>";

while ($row = $result->fetch_assoc()){
    echo "<tr>
        <td>{$row['id']}</td>
        <td>{$row['nome']}</td>
        <td>{$row['idade']}</td>
        <td>{$row['endereco']}</td>
        <td><a href='editar3.php?id={$row['id']}'>Editar</a></td>
        <td><a href='delete3.php?id={$row['id']}' onclick='return confirm(\"Tem certeza que deseja deletar este usuario?\")'>Deletar</a></td>
        </tr>";
}

echo "</table>";
$conn->close();
?>

<a href="index3.html"><button type="button">Pagina Inicial</button></a>