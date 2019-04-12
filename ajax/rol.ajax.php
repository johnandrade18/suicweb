<?php 

require_once "../controller/rol.controller.php";
require_once "../model/rol.model.php";

class AjaxRol{
/*====================================
=            Editar Rol            =
====================================*/

    public $idRol;

    public function ajaxEditarRol(){
        $item = "id_rol";
        $valor = $this->idRol;
        $respuesta = ControllerRol::ctrMostrarRol($item, $valor);
        echo json_encode($respuesta);
    }
/*====================================
=            Activar Rol            =
====================================*/

public $activarRol;
public $activarId;

public function ajaxActivarRol(){
    $tabla = "rol";
    $item1 = "condicion";
    $valor1 = $this->activarRol;
    $item2 = "id_rol";
    $valor2 = $this->activarId;
    $respuesta = ModelRol::mdlActualizarRol($tabla, $item1, $valor1, $item2, $valor2);
}
/*====================================
=      Revisar Rol Repetido         =
====================================*/
public $validarRol;
public function ajaxValidarRol(){
    $item = "nombre";
    $valor = $this->validarRol;
    $respuesta = ControllerRol::ctrMostrarRol($item, $valor);
    echo json_encode($respuesta);
}

}
/*====================================
=            Editar Rol            =
====================================*/
if(isset($_POST["idRol"])){
    $rol = new AjaxRol();
    $rol -> idRol = $_POST["idRol"];
    $rol -> ajaxEditarRol();

}
/*====================================
=            Activar Rol            =
====================================*/
if (isset($_POST["activarRol"])) {
    $activarRol = new AjaxRol();
    $activarRol -> activarRol = $_POST["activarRol"];
    $activarRol -> activarId = $_POST["activarId"];
    $activarRol -> ajaxActivarRol();
}
/*====================================
=      Revisar Rol Repetido         =
====================================*/
if (isset($_POST["validarRol"])) {
    $valRol = new AjaxRol();
    $valRol -> validarRol = $_POST["validarRol"];
    $valRol -> ajaxValidarRol();

}
?>