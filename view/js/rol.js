/*====================================
=            Editar Rol            =
====================================*/
$(document).on("click",".btnEditarRol", function() {
    var idRol = $(this).attr("idRol");
    var datos = new FormData();
    datos.append("idRol", idRol);
    $.ajax({
        url:"ajax/rol.ajax.php",
        method: "POST",
        data: datos,
        cache: false,
        contentType: false,
        processData: false,
        dataType: "json",
        success: function(respuesta){
            $("#idRol").val(respuesta["id_rol"]);
            $("#editarRol").val(respuesta["nombre"]);
            $("#rolActual").val(respuesta["nombre"]);
            $("#editarDescripcion").val(respuesta["descripcion"]);
            $("#descripcionActual").val(respuesta["descripcion"]);
        }
    });
})
/*====================================
=            Activar Rol            =
====================================*/
$(document).on("click",".btnActivar", function() {
    var idRol = $(this).attr("idRol");
    var condicionRol = $(this).attr("condicionRol");

    var datos = new FormData();
    datos.append("activarId", idRol);
    datos.append("activarRol", condicionRol);
    $.ajax({
        url:"ajax/rol.ajax.php",
        method: "POST",
        data: datos,
        cache: false,
        contentType: false,
        processData: false,
        success: function(respuesta){
            if (window.matchMedia("(max-width: 767px)").matches){
                 Swal.fire({
                  title: "El rol ha sido actualizado",
                  type: "success",
                  confirmButtonText: "¡Cerrar!"
                }).then(function(result) {
                    if (result.value) {

                        window.location = "rol";

                    }


                });
            }
        }
    })
    if(condicionRol == 0){
        $(this).removeClass('btn-success');
        $(this).addClass('btn-danger');
        $(this).html('Desactivado');
        $(this).attr('condicionRol', 1);
    }else{
        $(this).removeClass('btn-danger');
        $(this).addClass('btn-success');
        $(this).html('Activado');
        $(this).attr('condicionRol', 0);
    }
});
/*====================================
=      Revisar Rol Repetido         =
====================================*/
$("#rol").change(function() {
    $(".alert").remove();
    var rol = $(this).val();
    var datos = new FormData();
    datos.append("validarRol", rol);
    $.ajax({
        url:"ajax/rol.ajax.php",
        method: "POST",
        data: datos,
        cache: false,
        contentType: false,
        processData: false,
        dataType: "json",
        success: function(respuesta){
           if (respuesta){
             $("#rol").parent().before('<div class="alert alert-warning">Este rol ya existe</div>');
             $("#rol").val("");
           }
        }
    });
});
/*====================================
=            Eliminar Rol           =
====================================*/
$(document).on("click",".btnEliminarRol", function() {
    var idRol = $(this).attr("idRol");
    Swal.fire({
          title:'¿Está seguro de borrar el rol?',
          text: "¡Si no lo está puede cancelar la accíón!",
          type: 'warning',
          showCancelButton: true,
          confirmButtonColor: '#3085d6',
          cancelButtonColor: '#d33',
          confirmButtonText: 'Si, borrar rol!'
        }).then((result) => {
          if (result.value) {
            window.location = "index.php?ruta=rol&idRol="+idRol;
          }
        })
});