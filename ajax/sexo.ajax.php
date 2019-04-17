<?php 

require_once "../controller/sexo.controller.php";
require_once "../model/sexo.model.php";

class AjaxSexo{
/*====================================
=            Editar Sexo            =
====================================*/

    public $idSexo;

    public function ajaxEditarSexo(){
        $item = "id_sexo";
        $valor = $this->idSexo;
        $respuesta = ControllerSexo::ctrMostrarSexo($item, $valor);
        echo json_encode($respuesta);
    }
/*====================================
=            Activar Sexo            =
====================================*/

public $activarSexo;
public $activarId;

public function ajaxActivarSexo(){
    $tabla = "sexo";
    $item1 = "condicion";
    $valor1 = $this->activarSexo;
    $item2 = "id_sexo";
    $valor2 = $this->activarId;
    $respuesta = ModelSexo::mdlActualizarSexo($tabla, $item1, $valor1, $item2, $valor2);
}
/*====================================
=      Revisar Sexo Repetido         =
====================================*/
public $validarSexo;
public function ajaxValidarSexo(){
    $item = "nombre";
    $valor = $this->validarSexo;
    $respuesta = ControllerSexo::ctrMostrarSexo($item, $valor);
    echo json_encode($respuesta);
}

}
/*====================================
=            Editar Sexo            =
====================================*/
if(isset($_POST["idSexo"])){
    $sexo = new AjaxSexo();
    $sexo -> idSexo = $_POST["idSexo"];
    $sexo -> ajaxEditarSexo();

}
/*====================================
=            Activar Sexo            =
====================================*/
if (isset($_POST["activarSexo"])) {
    $activarSexo = new AjaxSexo();
    $activarSexo -> activarSexo = $_POST["activarSexo"];
    $activarSexo -> activarId = $_POST["activarId"];
    $activarSexo -> ajaxActivarSexo();
}
/*====================================
=      Revisar Rol Repetido         =
====================================*/
if (isset($_POST["validarSexo"])) {
    $valSexo = new AjaxSexo();
    $valSexo -> validarSexo = $_POST["validarSexo"];
    $valSexo -> ajaxValidarSexo();

}
?>