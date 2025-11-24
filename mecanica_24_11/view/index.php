<?php

require_once __DIR__ . '/../Controller/ClientesController.php';

$controller = new ClientesController();

// Ações da página
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if ($_POST['acao'] === 'criar') {
        $controller->criar($_POST['nome'], $_POST['telefone'], $_POST['CEP']);
    } elseif ($_POST['acao'] === 'deletar') {
        $controller->deletar($_POST['nome']);
    } elseif ($_POST['acao'] === 'atualizar') {
        $controller->atualizar($_POST['nomeOriginal'], $_POST['nome'], $_POST['telefone'], $_POST['CEP']);
    }

    header("Location: " . $_SERVER['PHP_SELF']);
    exit;
};

$lista = $controller->exibir();

?>

<!-- Formulário em HTML -->
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulário de Clientes</title>
</head>
<body>
<h1>Gerenciamento de clientes</h1>
<br>
<hr>
    <form method="POST">
    <input type="hidden" name="acao" value="criar">
    <input type="text" name="nome" placeholder="Nome do cliente:" required>
    <input type="text" name="telefone" placeholder="Telefone do cliente:" required>
    <input type="text" name="CEP" placeholder="CEP do cliente:" required>
    <button type="submit">Cadastrar</button>
    </form>


    <h2>Lista de Clientes Cadastrados</h2>
    <table>
    <thead>
    <?php foreach ($lista as $cliente): ?>
        <tbody>
            <?php echo "Nome: " . $cliente->getNome() . " | Telefone: " . $cliente->getTelefone() . " | CEP: " . $cliente->getCEP(); ?>
            <form method="POST" style="display:inline;">
                <input type="hidden" name="acao" value="deletar">
                <input type="hidden" name="nome" value="<?php echo $cliente->getNome(); ?>">
                <button type="submit">Excluir</button><br>
            </form>
        </tbody>
    </thead>
    </table>

    <form method="POST" style="display:inline;">
                <input type="hidden" name="acao" value="atualizar">
                <input type="hidden" name="nomeOriginal" value="<?php echo $cliente->getNome(); ?>">
                <input type="" name="nome" value="<?php echo $cliente->getNome(); ?>">
                <input type="" name="telefone" value="<?php echo $cliente->getTelefone(); ?>">
                <input type="" name="CEP" value="<?php echo $cliente->getCEP(); ?>">
                <button type="submit">Atualizar</button><br><br>
            </form>

</body>
</html><?php endforeach; ?>