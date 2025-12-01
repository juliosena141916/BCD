<?php

require_once __DIR__ . "/../Model/ClientesDAO.php";
require_once __DIR__ . "/../Model/Clientes.php";

class ClientesController{
    private $dao;

    // Construtor: cria o objeto DAO (responsável por salvar/carregar)
    public function __construct() {
        $this->dao = new ClientesDAO();
    }

    // Lista
    public function exibir() {
        return $this->dao->ExibirClientes();
    }

    // Cadastra
    public function criar($nome, $telefone, $CEP) {

        $cliente = new Clientes( $nome, $telefone, $CEP);
        $this->dao->criarCliente($cliente);
    }

    // Atualiza
    public function atualizar( $nomeOriginal, $novoNome, $novoTelefone, $novoCEP) {
        $this->dao->atualizarCliente( $nomeOriginal, $novoNome, $novoTelefone, $novoCEP);
    }

    // Exclui
    public function deletar($nome) {
        $this->dao->excluirCliente($nome);
    }
}
?>