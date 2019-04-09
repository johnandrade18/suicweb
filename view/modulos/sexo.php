<div class="content-wrapper">
    <section class="content-header">
      <h1>
        Administrar Sexo   
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Dashboard</a></li>
        <li><a href="#">Administrar Sexo</a></li>
      </ol>
    </section>
    <section class="content">
      <div class="box">
        <div class="box-header with-border">
            <button class="btn btn-primary" data-toggle="modal" data-target="#modalAgregarUsuario">Agregar Sexo</button>
        </div>

        <div class ="box-body">
          <table class="table table-bordered table-striped table-hover dt-responsive tablas">
            <thead>
              <tr>
                <th>#</th>
                <th>Nombre</th>
                <th>condicion</th>
                <th>Condicion</th>
                <th>Fecha Creacion</th>
                <th>Fecha Actualizacion</th>
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
              </tr>
              <tr>
                <td>1</td>
                <td>2</td>
                <td>3</td>
                <td>4</td>
                <td>5</td>
                <td>6</td>
                <td>7</td>
              </tr> 
              <tr>
                <td>1</td>
                <td>2</td>
                <td>3</td>
                <td>4</td>
                <td>5</td>
                <td>6</td>
                <td>7</td>
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
                        <!-- tipo documento -->
                          <div class="form-group col-md-6">
                              <label for="TipoDocumento">Tipo de Documento</label>
                                <select id="TipoDocumento" class="form-control">
                                    <option selected></option>
                                    <option>...</option>
                                </select>
                              </div>
                              <!-- Numero documento -->
                              <div class="form-group col-md-6">
                                  <label for="numeroDocumento">Numero de Documento</label>
                                    <input type="text" class="form-control" id="numeroDocumento" required>
                              </div>
                              <!-- Primer Nombre -->
                              <div class="form-group col-md-6">
                                  <label for="primerNombre">Primer Nombre</label>
                                    <input type="text" class="form-control" id="primerNombre" required>
                              </div>
                              <!-- Segundo Nombre -->
                              <div class="form-group col-md-6">
                                    <label for="segundoNombre">Segundo Nombre</label>
                                      <input type="text" class="form-control" id="segundoNombre">
                              </div>
                              <!-- Primer Apellido -->
                              <div class="form-group col-md-6">
                                  <label for="primeApellido">Primer Apellido</label >
                                  <input type="text" class="form-control" id="primeApellido" required>
                              </div>
                              <!-- Segundo Apellido -->
                              <div class="form-group col-md-6">
                                    <label for="segundoApellido">Segundo Apellido</label>
                                    <input type="text" class="form-control" id="segundoApellido">
                              </div>
                              <!-- Direccion -->
                              <div class="form-group col-md-12">
                                    <label for="direccion">Direccion</label>
                                    <input type="text" class="form-control" id="direccion" required>
                              </div>
                              <!-- Telefono -->
                            <div class="form-group col-md-6">
                                  <label for="telefono">Telefono</label>
                                  <input type="text" class="form-control" id="telefono">
                            </div>
                            <!-- Celular -->
                            <div class="form-group col-md-6">
                                  <label for="celular">Celular</label>
                                  <input type="text" class="form-control" id="celular" required>
                            </div>
                            <!-- Email -->
                            <div class="form-group col-md-6">
                                  <label for="email">Email</label>
                                  <input type="email" class="form-control" id="email" placeholder="E mail" required>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="sexo">Sexo</label>
                                  <select id="sexo" class="form-control" required>
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
                      $crearUsuario -> ctrCrearSexo();

                    ?>
              </div>
        </form>
      </div>
  </div>
</div>
  
  
  