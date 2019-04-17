  <div class="content-wrapper">
    <section class="content-header">
      <h1>
        Administrar Sexos   
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Dashboard</a></li>
        <li><a href="#">Administrar Sexos</a></li>
      </ol>
    </section>
    <section class="content">
      <div class="box">
        <div class="box-header with-border">
            <button class="btn btn-primary" data-toggle="modal" data-target="#modalAgregarSexo">Agregar Sexo</button>
        </div>

        <div class ="box-body">
          <table class="table table-bordered table-striped table-hover dt-responsive tablas">
            <thead>
              <tr>
                <th style="width: 15px;">#</th>
                <th>Nombre</th>
                <th>Condicion</th>
                <th>Fecha Creacion</th>
                <th>Fecha Actualizacion</th>
                <th>Acciones</th>
              </tr>
            </thead>
            <tbody>
            <?php 

              $item = null;
              $valor = null;
              $sexos = ControllerSexo::ctrMostrarSexo($item, $valor);

              foreach ($sexos as $key => $value) {
                echo '<tr>
                <td>'.($key+1).'</td>
                <td>'.$value["nombre"].'</td>';
                if($value["condicion"] != 0){

                  echo '<td><button class="btn btn-success btn-xs btnActivar" idSexo="'.$value["id_sexo"].'" condicionSexo="0">Activado</button></td>';

                  }else{

                    echo '<td><button class="btn btn-danger btn-xs btnActivar" idSexo="'.$value["id_sexo"].'" condicionSexo="1">Desactivado</button></td>';

                  }             
                echo'<td>'.$value["create_at"].'</td>
                <td>'.$value["update_at"].'</td>
                <td>                    

                    <div class="btn-group">
                        
                        <button class="btn btn-warning btnEditarSexo" idSexo="'.$value["id_sexo"].'" data-toggle="modal" data-target="#modalEditarSexo" style="margin-right: 5px"><i class="fa fa-pencil"></i></button>

                        <button class="btn btn-danger btnEliminarSexo" idSexo="'.$value["id_sexo"].'" style="margin-left: 5px"><i class="fa fa-times"></i></button>

                    </div>  
                    </td>
              </tr>';
                
              }

             ?>  
            </tbody>
          </table>
        </div>
      </div>
    </section>
  </div>

  <!--==================================
  =     Modal Agregar Sexo       =
  ==================================-->

<div class="modal fade" id="modalAgregarSexo" tabindex="-1" role="dialog" aria-labelledby="modalAgregarSexo" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form role="form" method="post">
                <div class="modal-header bg-primary">
                    <h3 class="modal-title" id="exampleModalLabel" style="padding-bottom: 10px;">Agregar Sexo</h3>
                      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true"><span class="icon-times"></span></span>
                      </button>
                </div>
                <div class="modal-body">
                  <div class="box-body">
                        <div class="form-row">
                              <!-- Sexo -->
                              <div class="form-group col-md-12">
                                  <label for="rol">Sexo</label>
                                    <input type="text" class="form-control" id="sexo" name="sexo" required>
                              </div>
                       </div>
                  </div>
                  <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                            <button type="submit" class="btn btn-primary">Guardar</button>
                  </div>
                  <?php

                      $crearSexo = new ControllerSexo();
                      $crearSexo -> ctrCrearSexo();

                    ?>
              </div>
        </form>
      </div>
  </div>
</div>
    <!--==================================
  =     Modal Editar Sexo       =
  ==================================-->

<div class="modal fade" id="modalEditarSexo" tabindex="-1" role="dialog" aria-labelledby="modalEditarSexo" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form role="form" method="post">
                <div class="modal-header bg-primary">
                    <h3 class="modal-title" id="exampleModalLabel" style="padding-bottom: 10px;">Editar Sexo</h3>
                      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true"><span class="icon-times"></span></span>
                      </button>
                </div>
                <div class="modal-body">
                  <div class="box-body">
                        <div class="form-row">
                              <!-- Sexo -->
                              <div class="form-group col-md-12">
                                <input type="hidden" name="idSexo" id="idSexo">
                                  <label for="sexo">Sexo</label>
                                    <input type="text" class="form-control" id="editarSexo" name="editarSexo" value="" required>
                                    <input type="hidden" name="sexoActual" id="sexoActual">
                              </div>
                       </div>
                  </div>
                  <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                            <button type="submit" class="btn btn-primary">Actualizar</button>
                  </div>
                 <?php

                      $editarSexo = new ControllerSexo();
                      $editarSexo -> ctrEditarSexo();

                    ?>
              </div>
        </form>
      </div>
  </div>
</div>
<?php
     $borarrSexo = new ControllerSexo();
     $borarrSexo -> ctrBorrarSexo();
?>
  
  
  
  