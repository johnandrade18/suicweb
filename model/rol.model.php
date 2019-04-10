<?php 
require_once "conexion.php";

class ModelRol{

    /*=============================================
                    MOSTRAR ROL
    =============================================*/

    static public function mdlMostrarRol($tabla, $item, $valor){
        if ($item != null) {
             $stmt = Conexion::conectar()->prepare("SELECT * FROM $tabla WHERE $item = :$item"); 
             $stmt -> bindParam(":".$item, $valor, PDO::PARAM_STR);
             $stmt -> execute();
             return $stmt -> fetch();
        }else {
             $stmt = Conexion::conectar()->prepare("SELECT * FROM $tabla "); 
             $stmt -> execute();
             return $stmt -> fetchAll();
        }
        $stmt -> close();
        $stmt = null;
    }

     /*=============================================
                    REGISTRAR ROL
    =============================================*/

    static public function mdlCrearRol($tabla, $datos){
        $stmt = Conexion::conectar()->prepare("INSERT INTO $tabla(nombre,descripcion) VALUES (:nombre, :descripcion) ");
        $stmt->bindParam(":nombre", $datos["nombre"], PDO::PARAM_STR);
        $stmt->bindParam(":descripcion", $datos["descripcion"], PDO::PARAM_STR);

        if ($stmt->execute()) {
            return "ok";
        }else {
            return "error";
        }
        $stmt->close();
        $stmt = null;
    }
}
?>