<?php 

class ControllerRol{

    /*=============================================
                    CREAR DE ROL
    =============================================*/

    static public function ctrCrearRol(){
      if (isset($_POST["rol"])) {
        if (preg_match('/^[-a-zA-Z]+$/',$_POST["rol"]) && 
            preg_match('/^[-a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ ]+$/',$_POST["descripcion"])){
          $tabla = "rol";
          $datos = array("nombre" => $_POST["rol"],
                         "descripcion" => $_POST["descripcion"]);
          $respuesta = ModelRol::mdlCrearRol($tabla, $datos);

          if ($respuesta == "ok") {
            echo '<script>
               Swal.fire({
               title: "¡El rol ha sido guardado correctamente!",
               showConfirmButton: "true",
               type: "success",
               confirmButtonText: "Cerrar"
              }).then((result)=>{
                if(result.value){
                  window.location = "rol";
                }
              });
          </script>'; 
          }
        }else {
          echo '<script>
               Swal.fire({
               title: "¡El rol no puede ir vacío o llevar caracteres especiales!",
               showConfirmButton: "true",
               type: "error",
               confirmButtonText: "Cerrar"
              }).then((result)=>{
                if(result.value){
                  window.location = "rol";
                }
              });
          </script>';
        }
      }
    }
    /*=============================================
                    MOSTRAR ROLES
    =============================================*/
    static public function ctrMostrarRol($item, $valor){
        $tabla = "rol";

        $respuesta = ModelRol::mdlMostrarRol($tabla, $item, $valor);

        return $respuesta;
    }
  /*=============================================
                    EDITAR ROLES
    =============================================*/
    static public function ctrEditarRol(){
        if (isset($_POST["editarRol"])) {
          if (preg_match('/^[-a-zA-Z]+$/',$_POST["editarRol"]) && 
              preg_match('/^[-a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ ]+$/',$_POST["editarDescripcion"])){
            $tabla = "rol";
            $datos = array("id_rol" => $_POST["idRol"],
                           "nombre" => $_POST["editarRol"],
                           "descripcion" => $_POST["editarDescripcion"]);
            $respuesta = ModelRol::mdlEditarRol($tabla, $datos);
            if ($respuesta == "ok") {
            echo '<script>
               Swal.fire({
               title: "¡El rol ha sido editado correctamente!",
               showConfirmButton: "true",
               type: "success",
               confirmButtonText: "Cerrar"
              }).then((result)=>{
                if(result.value){
                  window.location = "rol";
                }
              });
          </script>';
          } 
          }else {
            echo '<script>
               Swal.fire({
               title: "¡El rol no puede ir vacío o llevar caracteres especiales!",
               showConfirmButton: "true",
               type: "error",
               confirmButtonText: "Cerrar"
              }).then((result)=>{
                if(result.value){
                  window.location = "rol";
                }
              });
          </script>';
          }
        }
    }
     /*=============================================
                    BORAR ROLES
    =============================================*/
    static public function ctrBorrarRol(){
      if (isset($_GET["idRol"])) {
        $tabla = "rol";
        $datos = $_GET["idRol"];
        $respuesta = ModelRol::mdlBorrarRol($tabla, $datos);
        if ($respuesta == "ok") {
          echo'<script>

        Swal.fire({
            type: "success",
            title: "El rol ha sido borrado correctamente",
            showConfirmButton: true,
            confirmButtonText: "Cerrar",
            closeOnConfirm: false
            }).then(function(result) {
                if (result.value) {

                window.location = "rol";

                }
              })

        </script>';
        }
      }
    }
  }
?>