<?php 

class Conexion{

    public function conectar(){ 
      
      // $link = new PDO("pgsql:host=localhost;dbname=apprecaudo;port=5432", "postgres", "0218");
        $link = new PDO("mysql:host=localhost;dbname=suicweb", "root", "");
      $link->exec("set name utf8");
      return $link;                
    }
}

?>