<?php

class Clientes {

    private $id;
    private $nome;
    private $telefone;
    private $CEP;

    public function __construct($nome,$telefone,$CEP){
        $this->nome=$nome;
        $this->telefone=$telefone;
        $this->CEP=$CEP;
    }

    public function setNome($nome){
        $this->nome=$nome;
    }

    public function setTelefone($telefone){
        $this->telefone=$telefone;
    }
    
    public function setCEP($CEP){
        $this->CEP=$CEP;
    }



    public function getNome(){
        return $this->nome;
    }
    public function getTelefone(){
        return $this->telefone;
    }
    public function getCEP(){
        return $this->CEP;
    }
};

