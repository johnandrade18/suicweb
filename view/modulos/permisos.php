  <div class ="content-wrapper">
    <section class="content-header">
      <h1>
        Administrar Permisos   
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Dashboard</a></li>
        <li><a href="#">Administrar permisos</a></li>
      </ol>
    </section>
    <section class="content">
      <div class="box">
        <div class="box-header with-border">
            <button class="btn btn-primary" data-toggle="modal" data-target="#modalAgregarUsuario">Agregar Permiso</button>
        </div>

        <div class="box-body">
          <table class="table table-bordered table-striped table-hover dt-responsive tablas">
            <thead>
              <tr>
                <th>#</th>
                <th>Numero de Documento</th>
                <th>Nombre de usuario</th>
                <th>Rol</th>
                <th>Email</th>
                <th>Password</th>
                <th>Condicion</th>
                <th>Acciones</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>1</td>
                <td>2</td>
                <td>3</td>
                <td>4</td>
                <td>5</td>
                <td>6</td>
                <td>7</td>
                <td>8</td>
              </tr>
              <tr>
                <td>1</td>
                <td>2</td>
                <td>3</td>
                <td>4</td>
                <td>5</td>
                <td>6</td>
                <td>7</td>
                <td>8</td>
              </tr> 
              <tr>
                <td>1</td>
                <td>2</td>
                <td>3</td>
                <td>4</td>
                <td>5</td>
                <td>6</td>
                <td>7</td>
                <td>8</td>
              </tr>              
            </tbody>
          </table>
        </div>
      </div>
    </section>
  </div>

  <!--==================================
  =     Modal Agregar Usuario       =
  ==================================-->

<div class="modal fade" id="modalAgregarUsuario" tabindex="-1" role="dialog" aria-labelledby="modalAgregarUsuario" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form role="form" method="post" enctype="multipart/form-data">
                <div class="modal-header bg-primary">
                    <h3 class="modal-title" id="exampleModalLabel">Agregar Usuario</h3>
                      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true"><span class="icon-times"></span></span>
                      </button>
                </div>
                <div class="modal-body">
                  <div class="box-body">
                        <div class="form-row">
                              <!-- Nick Usuario -->
                              <div class="form-group col-md-6">
                                  <label for="nickUsuario">Nick Usuario</label>
                                    <input type="text" class="form-control" id="nickUsuario" required>
                              </div>
                              <!-- numeroDocumento -->
                              <div class="form-group col-md-6">
                                  <label for="numeroDocumento">Numero Documento</label>
                                    <input type="text" class="form-control" id="numeroDocumento" required>
                              </div>
                            <!-- Email -->
                            <div class="form-group col-md-6">
                                  <label for="email">Email</label>
                                  <input type="email" class="form-control" id="email" placeholder="E mail" required>
                            </div>
                            <!-- Password -->
                            <div class="form-group col-md-6">
                                  <label for="password">Password</label>
                                  <input type="password" class="form-control" id="password" placeholder="E mail" required>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="rol">Rol</label>
                                  <select id="rol" class="form-control" required>
                                      <option selected></option>
                                      <option>...</option>
                                  </select>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="fotoPerfil">Foto de Perfil</label>
                                  <input type="file" name="adjunto" accept=".pdf,.jpg,.png" multiple id="fotoPerfil">
                                  <p class="help-block">Peso maximo de la foto 200 MB</p>
                                  <img src="view/img/usuarios/default/user.png" class="img-thumbnail" width="100px">
                            </div>
                      </div>
                  </div>
                  <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                            <button type="submit" class="btn btn-primary">Guardar</button>
                  </div>
                  <?php

                      $crearUsuario = new ControllerUsuarios();
                      $crearUsuario -> ctrCrearUsuario();

                    ?>
              </div>
        </form>
      </div>
  </div>
</div>
  
  
  