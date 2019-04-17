/*====================================
=            Editar Sexo            =
====================================*/
$(document).on("click",".btnEditarSexo", function() {
    var idSexo = $(this).attr("idSexo");
    var datos = new FormData();
    datos.append("idSexo", idSexo);
    $.ajax({
        url:"ajax/sexo.ajax.php",
        method: "POST",
        data: datos,
        cache: false,
        contentType: false,
        processData: false,
        dataType: "json",
        success: function(respuesta){
            $("#idSexo").val(respuesta["id_sexo"]);
            $("#editarSexo").val(respuesta["nombre"]);
            $("#sexoActual").val(respuesta["nombre"]);
        }
    });
})
/*====================================
=            Activar SEXO            =
====================================*/
$(document).on("click",".btnActivar", function() {
    var idSexo = $(this).attr("idSexo");
    var condicionSexo = $(this).attr("condicionSexo");

    var datos = new FormData();
    datos.append("activarId", idSexo);
    datos.append("activarSexo", condicionSexo);
    $.ajax({
        url:"ajax/sexo.ajax.php",
        method: "POST",
        data: datos,
        cache: false,
        contentType: false,
        processData: false,
        success: function(respuesta){
            if (window.matchMedia("(max-width: 767px)").matches){
                 Swal.fire({
                  title: "El sexo ha sido actualizado",
                  type: "success",
                  confirmButtonText: "¡Cerrar!"
                }).then(function(result) {
                    if (result.value) {

                        window.location = "sexo";

                    }


                });
            }
        }
    })
    if(condicionSexo == 0){
        $(this).removeClass('btn-success');
        $(this).addClass('btn-danger');
        $(this).html('Desactivado');
        $(this).attr('condicionSexo', 1);
    }else{
        $(this).removeClass('btn-danger');
        $(this).addClass('btn-success');
        $(this).html('Activado');
        $(this).attr('condicionSexo', 0);
    }
});
/*====================================
=      Revisar Sexo Repetido         =
====================================*/
$("#sexo").change(function() {
    $(".alert").remove();
    var sexo = $(this).val();
    var datos = new FormData();
    datos.append("validarSexo", sexo);
    $.ajax({
        url:"ajax/sexo.ajax.php",
        method: "POST",
        data: datos,
        cache: false,
        contentType: false,
        processData: false,
        dataType: "json",
        success: function(respuesta){
           if (respuesta){
             $("#sexo").parent().before('<div class="alert alert-warning">Este sexo ya existe</div>');
             $("#sexo").val("");
           }
        }
    });
});
/*====================================
=            Eliminar Sexo           =
====================================*/
$(document).on("click",".btnEliminarSexo", function() {
    var idSexo = $(this).attr("idSexo");
    Swal.fire({
          title:'¿Está seguro de borrar el sexo?',
          text: "¡Si no lo está puede cancelar la accíón!",
          type: 'warning',
          showCancelButton: true,
          confirmButtonColor: '#3085d6',
          cancelButtonColor: '#d33',
          confirmButtonText: 'Si, borrar sexo!'
        }).then((result) => {
          if (result.value) {
            window.location = "index.php?ruta=sexo&idSexo="+idSexo;
          }
        })
});