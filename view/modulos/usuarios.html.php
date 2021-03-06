  <div class="content-wrapper">
    <section class="content-header">
      <h1>
        Administrar Usuarios   
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Dashboard</a></li>
        <li><a href="#">Administrar usuarios</a></li>
      </ol>
    </section>
    <section class="content">
      <div class="box">
        <div class="box-header with-border">
            <button class="btn btn-primary" data-toggle="modal" data-target="#modalAgregarUsuario">Agregar Usuario</button>
        </div>

        <div class="box-body">
          <table class="table table-bordered table-striped table-hover dt-responsive tablas">
            <thead>
              <tr>
                <th>Documento</th>
                <th>Numero Documento</th>
                <th>Primer Nombre</th>
                <th>Segundo Nombre</th>
                <th>Primer Apellido</th>
                <th>Segundo Apellido</th>
                <th>Foto</th>
                <th>Direccion</th>
                <th>Telefono</th>
                <th>Celular</th>
                <th>E-mail</th>
                <th>Sexo</th>
                <th>condicion</th>
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
                <td>8</td>
                <td>9</td>
                <td>10</td>
                <td>11</td>
                <td>12</td>
                <td>13</td>
                <td>14</td>
                <td>15</td>
                <td>16</td>
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
                <td>9</td>
                <td>10</td>
                <td>11</td>
                <td>12</td>
                <td>13</td>
                <td>14</td>
                <td>15</td>
                <td>16</td>
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
                <td>9</td>
                <td>10</td>
                <td>11</td>
                <td>12</td>
                <td>13</td>
                <td>14</td>
                <td>15</td>
                <td>16</td>
              </tr>              
            </tbody>
          </table>
        </div>
      </div>
    </section>
  </div>

  /*==================================
  =     Modal Agregar Usuario       =
  ==================================*/

  <div class="modal fade" id="modalAgregarUsuario" tabindex="-1" role="dialog" aria-labelledby="modalAgregarUsuario" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header bg-primary">
        <h3 class="modal-title" id="exampleModalLabel">Agregar Usuario</h3>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true"><span class="icon-times"></span></span>
        </button>
      </div>
      <div class="modal-body">
        <div class="box-body">
         <form role="form" method="post" enctype="multipart/form-data">
              <div class="form-row">
                <div class="form-group col-md-6">
                  <label for="TipoDocumento">Tipo de Documento</label>
                  <select id="TipoDocumento" class="form-control">
                    <option selected></option>
                    <option>...</option>
                  </select>
                </div>
                <div class="form-group col-md-6">
                  <label for="numeroDocumento">Numero de Documento</label>
                  <input type="text" class="form-control" id="numeroDocumento">
                </div>
                <div class="form-group col-md-6">
                  <label for="primerNombre">Primer Nombre</label>
                  <input type="text" class="form-control" id="primerNombre">
                </div>
                <div class="form-group col-md-6">
                  <label for="segundoNombre">Segundo Nombre</label>
                  <input type="text" class="form-control" id="segundoNombre">
                </div>
                <div class="form-group col-md-6">
                  <label for="primeApellido">Primer Apellido</label>
                  <input type="text" class="form-control" id="primeApellido">
                </div>
                <div class="form-group col-md-6">
                  <label for="segundoApellido">Segundo Apellido</label>
                  <input type="text" class="form-control" id="segundoApellido">
                </div>
                <div class="form-group col-md-12">
                  <label for="direccion">Direccion</label>
                  <input type="text" class="form-control" id="direccion">
                </div>
                <div class="form-group col-md-6">
                  <label for="telefono">Telefono</label>
                  <input type="text" class="form-control" id="telefono">
                </div>
                <div class="form-group col-md-6">
                  <label for="celular">Celular</label>
                  <input type="text" class="form-control" id="celular">
                </div>
                <div class="form-group col-md-6">
                  <label for="email">Email</label>
                  <input type="email" class="form-control" id="email" placeholder="E mail">
                </div>
                <div class="form-group col-md-6">
                  <label for="sexo">Sexo</label>
                  <select id="sexo" class="form-control">
                    <option selected></option>
                    <option>...</option>
                  </select>
                </div>
              </div>
              <div class="form-group col-md-6">
                  <label for="fotoPerfil">Foto de Perfil</label>
                  <input type="file" name="adjunto" accept=".pdf,.jpg,.png" multiple id="fotoPerfil">
                  <p class="help-block">Peso maximo de la foto 200 MB</p>
                  <img src="view/img/usuarios/default/user.png" class="img-thumbnail" width="100px">
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                  <button type="submit" class="btn btn-primary">Guardar</button>
                </div>
                <?php 
                  $crearUsuario = new ControllerUsuarios();
                  $crearUsuario -> ctrCrearUsuario();

                ?>
            </form>
        </div>
      </div>
    </div>
  </div>
</div>
  
  
  