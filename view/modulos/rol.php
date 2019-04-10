  <div class="content-wrapper">
    <section class="content-header">
      <h1>
        Administrar Roles   
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Dashboard</a></li>
        <li><a href="#">Administrar Roles</a></li>
      </ol>
    </section>
    <section class="content">
      <div class="box">
        <div class="box-header with-border">
            <button class="btn btn-primary" data-toggle="modal" data-target="#modalAgregarRol">Agregar Rol</button>
        </div>

        <div class ="box-body">
          <table class="table table-bordered table-striped table-hover dt-responsive tablas">
            <thead>
              <tr>
                <th style="width: 15px;">#</th>
                <th>Nombre</th>
                <th>Descripcion</th>
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
              $roles = ControllerRol::ctrMostrarRol($item, $valor);

              foreach ($roles as $key => $value) {
                echo '<tr>
                <td>'.$value["id_rol"].'</td>
                <td>'.$value["nombre"].'</td>
                <td>'.$value["descripcion"].'</td>';
                if($value["condicion"] != 0){

                    echo '<td><button class="btn btn-success btn-xs btnActivar" idUsuario="'.$value["id_rol"].'" estadoUsuario="0">Activado</button></td>';

                  }else{

                    echo '<td><button class="btn btn-danger btn-xs btnActivar" idUsuario="'.$value["id_rol"].'" estadoUsuario="1">Desactivado</button></td>';

                  }             
                echo'<td>'.$value["create_at"].'</td>
                <td>'.$value["update_at"].'</td>
                <td>                    

                    <div class="btn-group">
                        
                        <button class="btn btn-warning btnEditarRol" style="margin-right: 5px" idRol="'.$value["id_rol"].'" data-toggle="modal" data-target="#modalEditarRol"><i class="fa fa-pencil"></i></button>

                        <button class="btn btn-danger btnEliminarRol" style="margin-left: 5px" idRol="'.$value["id_rol"].'"><i class="fa fa-times"></i></button>

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
  =     Modal Agregar Usuario       =
  ==================================-->

<div class="modal fade" id="modalAgregarRol" tabindex="-1" role="dialog" aria-labelledby="modalAgregarRol" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form role="form" method="post" enctype="multipart/form-data">
                <div class="modal-header bg-primary">
                    <h3 class="modal-title" id="exampleModalLabel" style="padding-bottom: 10px;">Agregar Rol</h3>
                      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true"><span class="icon-times"></span></span>
                      </button>
                </div>
                <div class="modal-body">
                  <div class="box-body">
                        <div class="form-row">
                              <!-- Rol -->
                              <div class="form-group col-md-6">
                                  <label for="rol">Rol</label>
                                    <input type="text" class="form-control" id="rol" name="rol" required>
                              </div>
                              <!-- Descripcion -->
                              <div class="form-group col-md-6">
                                  <label for="descripcion">Descripcion</label>
                                    <input type="text" class="form-control" id="descripcion" name="descripcion" required>
                              </div>
                       </div>
                  </div>
                  <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                            <button type="submit" class="btn btn-primary">Guardar</button>
                  </div>
                  <?php

                      $crearRol = new ControllerRol();
                      $crearRol -> ctrCrearRol();

                    ?>
              </div>
        </form>
      </div>
  </div>
</div>
  
  
  