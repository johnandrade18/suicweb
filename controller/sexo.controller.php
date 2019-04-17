<?php 

class ControllerSexo{

    /*=============================================
                    CREAR DE SEXO
    =============================================*/

    static public function ctrCrearSexo(){
      if (isset($_POST["sexo"])) {
        if (preg_match('/^[-a-zA-Z]+$/',$_POST["sexo"])){
          $tabla = "sexo";
          $datos = $_POST["sexo"];
          $respuesta = ModelSexo::mdlCrearSexo($tabla, $datos);

          if ($respuesta == "ok") {
            echo '<script>
               Swal.fire({
               title: "¡El sexo ha sido guardado correctamente!",
               showConfirmButton: "true",
               type: "success",
               confirmButtonText: "Cerrar"
              }).then((result)=>{
                if(result.value){
                  window.location = "sexo";
                }
              });
          </script>'; 
          }
        }else {
          echo '<script>
               Swal.fire({
               title: "¡El sexo no puede ir vacío o llevar caracteres especiales!",
               showConfirmButton: "true",
               type: "error",
               confirmButtonText: "Cerrar"
              }).then((result)=>{
                if(result.value){
                  window.location = "sexo";
                }
              });
          </script>';
        }
      }
    }
    /*=============================================
                    MOSTRAR SEXOS
    =============================================*/
    static public function ctrMostrarSexo($item, $valor){
        $tabla = "sexo";

        $respuesta = ModelSexo::mdlMostrarSexo($tabla, $item, $valor);

        return $respuesta;
    }
  /*=============================================
                    EDITAR SEXO
    =============================================*/
    static public function ctrEditarSexo(){
        if (isset($_POST["editarSexo"])) {
          if (preg_match('/^[-a-zA-Z]+$/',$_POST["editarSexo"])){
            $tabla = "sexo";
            $datos = array("id_sexo" => $_POST["idSexo"],
                           "nombre" => $_POST["editarSexo"]);
            $respuesta = ModelSexo::mdlEditarSexo($tabla, $datos);
            if ($respuesta == "ok") {
            echo '<script>
               Swal.fire({
               title: "¡El sexo ha sido editado correctamente!",
               showConfirmButton: "true",
               type: "success",
               confirmButtonText: "Cerrar"
              }).then((result)=>{
                if(result.value){
                  window.location = "sexo";
                }
              });
          </script>';
          } 
          }else {
            echo '<script>
               Swal.fire({
               title: "¡El sexo no puede ir vacío o llevar caracteres especiales!",
               showConfirmButton: "true",
               type: "error",
               confirmButtonText: "Cerrar"
              }).then((result)=>{
                if(result.value){
                  window.location = "sexo";
                }
              });
          </script>';
          }
        }
    }
     /*=============================================
                    BORAR SEXOS
    =============================================*/
    static public function ctrBorrarSexo(){
      if (isset($_GET["idSexo"])) {
        $tabla = "sexo";
        $datos = $_GET["idSexo"];
        $respuesta = ModelSexo::mdlBorrarSexo($tabla, $datos);
        if ($respuesta == "ok") {
          echo'<script>

        Swal.fire({
            type: "success",
            title: "El sexo ha sido borrado correctamente",
            showConfirmButton: true,
            confirmButtonText: "Cerrar",
            closeOnConfirm: false
            }).then(function(result) {
                if (result.value) {

                window.location = "sexo";

                }
              })

        </script>';
        }
      }
    }
  }
?>