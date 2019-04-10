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
          $datos = array("nombre" =>$_POST["rol"],
                         "descripcion" =>$_POST["descripcion"]);
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

  }
?>