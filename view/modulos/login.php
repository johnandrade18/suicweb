<div id="back"></div>
<div class="login-box">
  <div class="login-logo">
    <img src="view/img/plantilla/600.png" class="img-responsive">
  </div>
  <div class="login-box-body">
    <h1 class="login-box-msg" >Inicio de Sesión</h1>
    <p class="login-box-msg">Control de acceso al sistema</p>

    <form method="post">
      <div class="form-group has-feedback">
        <input type="text" class="form-control" placeholder="Usuario" name="ingUsuario" required>
        <span class="glyphicon glyphicon-user form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
        <input type="password" class="form-control" placeholder="Contraseña" name="ingPassword" required>
        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
      </div>
      <div class="row">
        <div class="container-fluid">
          <button type="submit" class="btn btn-primary btn-lg btn-block">Ingresar &nbsp;<span class=" pt-1 icon-sign-in"></span></button>
        </div>
      </div>
      <?php 
        $login = new ControllerUsuarios();
        $login -> ctrIngresoUsuario();
      ?> 
    </form>
  </div>
</div>