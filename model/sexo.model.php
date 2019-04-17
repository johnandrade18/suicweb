<?php 
require_once "conexion.php";

class ModelSexo{

    /*=============================================
                    MOSTRAR Sexo
    =============================================*/

    static public function mdlMostrarSexo($tabla, $item, $valor){
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
                    REGISTRAR SEXO
    =============================================*/

    static public function mdlCrearSexo($tabla, $datos){
        $stmt = Conexion::conectar()->prepare("INSERT INTO $tabla (nombre) VALUES (:nombre) ");
        $stmt->bindParam(":nombre", $datos, PDO::PARAM_STR);

        if ($stmt->execute()) {
            return "ok";
        }else {
            return "error";
        }
        $stmt->close();
        $stmt = null;
    }
      /*=============================================
                    EDITAR SEXO
    =============================================*/

    static public function mdlEditarSexo($tabla, $datos){
        $stmt = Conexion::conectar()->prepare("UPDATE $tabla SET nombre = :nombre WHERE id_sexo = :id_sexo");
        $stmt->bindParam(":nombre", $datos["nombre"], PDO::PARAM_STR);
        $stmt->bindParam(":id_sexo", $datos["id_sexo"], PDO::PARAM_STR);

        if ($stmt->execute()) {
            return "ok";
        }else {
            return "error";
        }
        $stmt->close();
        $stmt = null;
    }

    /*=============================================
                    ACTUALIZAR SEXO
    =============================================*/
    static public function mdlActualizarSexo($tabla, $item1, $valor1, $item2, $valor2){
        $stmt = Conexion::conectar()->prepare("UPDATE $tabla SET $item1 = :$item1 WHERE $item2 = :$item2");
        $stmt -> bindParam(":".$item1, $valor1, PDO::PARAM_STR);
        $stmt -> bindParam(":".$item2, $valor2, PDO::PARAM_STR);
        if ($stmt->execute()) {
            return "ok";
        }else {
            return "error";
        }
        $stmt->close();
        $stmt = null;
    }
    /*=============================================
                    BORRAR SEXO
    =============================================*/
    static public function mdlBorrarSexo($tabla, $datos){
        $stmt = Conexion::conectar()->prepare("DELETE FROM $tabla WHERE id_sexo = :id_sexo");
        $stmt->bindParam(":id_sexo", $datos, PDO::PARAM_STR);

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