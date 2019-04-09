<?php 

class ControllerUsuarios{

    /*=============================================
                    INGRESO DE USUARIO
    =============================================*/

    static public function ctrIngresoUsuario(){

      if (isset($_POST["ingUsuario"])){

            if (preg_match('/^[-a-zA-Z0-9]+$/',$_POST["ingUsuario"]) && 
                preg_match('/^[-a-zA-Z0-9]+$/',$_POST["ingPassword"])){
                
                $tabla = "usuario";
                $item = "nick_usuario";
                $valor = $_POST["ingUsuario"];

                $respuesta = ModelUsuarios::MdlMostrarUsuarios($tabla, $item, $valor);

                if($respuesta["nick_usuario"] == $_POST["ingUsuario"] && $respuesta["password"] == $_POST["ingPassword"]){

                    $_SESSION["iniciarSesion"] = "ok";

                    echo '<script>

                        window.location = "dashboard";

                    </script>';

                }else {
                    
                    echo '<br><div class="alert alert-danger">Error al ingresar, vuelve a intentarlo</div>';
                }
            }
        }  
    }

    /*=============================================
                    REGISTRO DE USUARIO
    =============================================*/

    static public function ctrCrearUsuario(){

        if (isset($_POST["tipoDocumento"])){

            if (preg_match('/^[a-zA-Z ]+$/',$_POST["tipoDocumento"]) &&
                preg_match('/^[0-9]+$/',$_POST["numeroDocumento"]) &&
                preg_match('/^[a-zA-ZñÑáéíóúÁÉÍÓÚ]+$/', $_POST["primerNombre"]) &&
                preg_match('/^[a-zA-ZñÑáéíóúÁÉÍÓÚ]+$/', $_POST["segundoNombre"]) &&
                preg_match('/^[a-zA-ZñÑáéíóúÁÉÍÓÚ]+$/', $_POST["primerApellido"]) &&
                preg_match('/^[a-zA-ZñÑáéíóúÁÉÍÓÚ]+$/', $_POST["segundoApellido"]) &&
                preg_match('/^[-a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ ]+$/', $_POST["direccion"]) &&
                preg_match('/^[0-9]+$/', $_POST["telefono"]) &&
                preg_match('/^[0-9]+$/', $_POST["celular"]) &&
                preg_match('/^[-a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ@.]+$/', $_POST["email"]) &&
                preg_match('/^[-a-zA-Z0-9]+$/',$_POST["sexo"])){

                $tabla = "usuario";
                $datos = array("id_tipo_documento" =>$_POST["tipoDocumento"],
                               "numero_documento" =>$_POST["numeroDocumento"],
                               "primer_nombre" =>$_POST["primerNombre"],
                               "segundo_nombre" =>$_POST["segundoNombre"],
                               "primer_apellido" =>$_POST["primerApellido"],
                               "segundo_apellido" =>$_POST["segundoApellido"],
                               "direccion" =>$_POST["direccion"],
                               "telefono" =>$_POST["telefono"],
                               "celular" =>$_POST["celular"],
                               "email" =>$_POST["email"],
                               "id_sexo" =>$_POST["sexo"],
                               "foto" =>$_POST["foto"],
                );
                
                

            }else {
                echo '<script>
                    Swal.fire({
                          type: "error",
                          title: "El nombre no puede ir vacio o con caracteres especiales",
                          showConfirmButton: true,
                          confirmButtonText:"Cerrar",
                          closeOnComfirm: false
                            

                           }).then((result)=>{

                            if(result.value){
                                window.location = "usuarios";
                            } 

                        });
                    
                </script>'; 
            }
            
        }
    }
}


?>