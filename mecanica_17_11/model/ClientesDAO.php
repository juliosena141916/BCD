<?php
require_once 'Clientes.php';
require_once 'Connection.php';

class ClientesDAO {
    private $conn;

    public function __construct() {
        $this->conn = Connection::getInstance();

        // Cria a tabela se não existir
        $this->conn->exec("
            CREATE TABLE IF NOT EXISTS clientes (
                id INT AUTO_INCREMENT PRIMARY KEY,
                nome VARCHAR(100) NOT NULL UNIQUE,
                telefone VARCHAR(50) NOT NULL,
                CEP VARCHAR(20) NOT NULL,
            )
        ");
    }
    

    // CREATE
    public function criarCliente(Clientes $id) {
        $stmt = $this->conn->prepare("
            INSERT INTO clientes (nome, telefone, CEP)
            VALUES (:nome, :telefone, :CEP)
        ");
        $stmt->execute([
            ':nome' => $id->getNome(),
            ':telefone' => $id->getTelefone(),
            ':CEP' => $id->getCEP()
        ]);
    }

    // READ
    public function ExibirClientes() {
        $stmt = $this->conn->query("SELECT * FROM clientes ORDER BY nome");
        $result = [];
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $result[] = new Clientes(
                $row['nome'],
                $row['telefone'],
                $row['CEP']
            );
        }
        return $result;
    }

    // UPDATE
    public function atualizarCliente($nomeOriginal, $novoNome, $novoTelefone, $novoCEP) {
        $stmt = $this->conn->prepare("
            UPDATE clientes
            SET nome = :novoNome, telefone = :novoTelefone, CEP = :novoCEP
            WHERE nome = :nomeOriginal
        ");
        $stmt->execute([
            ':novoNome' => $novoNome,
            ':novoTelefone' => $novoTelefone,
            ':novoCEP' => $novoCEP,
            ':nomeOriginal' => $nomeOriginal
        ]);
    }

    // DELETE
    public function excluirCliente($nome) {
        $stmt = $this->conn->prepare("DELETE FROM clientes WHERE nome = :nome");
        $stmt->execute([':nome' => $nome]);
    }

    // BUSCAR POR NOME
    public function buscarPorNome($nome) {
        $stmt = $this->conn->prepare("SELECT * FROM clientes WHERE nome = :nome LIMIT 1");
        $stmt->execute([':nome' => $nome]);
        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($row) {
            return new Clientes(
                $row['nome'],
                $row['telefone'],
                $row['CEP']
            );
        }
        return null;
    }
}