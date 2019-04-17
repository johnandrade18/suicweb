<?php 

session_start()

?>

<!DOCTYPE html>
<html lang="es">
<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">

  <title>SUIC | Sistema unificado de informacion Consolidada</title>
  <link rel="icon" href="view/img/plantilla/logo-sm.png" >

  <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <link rel="canonical" href="http://suicweb.com">
  <meta name="author" content="John Alexander Andrade Diaz">
  <link rel="manifest" href="">
  <meta name="description" content="Sistema de flota y recaudo">
  <meta name="keywords" content="john, andrade, sistema, flota, recaudo, vehiculos, gps, unico, informacion,consolidada,suic, suicweb, boostrap, html5, css3, js, desarrollador, sistemas">
  <meta name="twitter:card" content="summary_larga_image">
  <meta name="twitter:site" content="@johnandrade18">
  <meta name="twitter:creater" content="@johnandrade18">
  <meta name="twitter:title" content="Sistema unico de informacion consolida">
  <meta name="description" content="Sistema de flota y recaudo">
  <meta name="twitter:image" content="logo-sm.png">
  <meta name="og:locale" content="es_CO">
  <meta name="og:type" content="website">
  <meta name="og:title" content="Sistema unico de informacion consolida">
  <meta name="og:description" content="Sistema de flota y recaudo">
  <meta name="og:url" content="http://suicweb.com">
  <meta name="og:site_name" content="http://suicweb.com">
  <meta name="og:image" content="logo-sm.png">


  <!-- Bootstrap 3.3.7 -->
  <link rel="stylesheet" href="view/bower_components/bootstrap/dist/css/bootstrap.min.css">

  <!-- DataTables -->
  <link rel="stylesheet" href="view/bower_components/datatables/css/dataTables.bootstrap4.min.css">
  <link rel="stylesheet" href="view/bower_components/datatables/css/responsive.bootstrap.min.css">

  <!-- Font Awesome -->
  <link rel="stylesheet" href="view/bower_components/font-awesome/css/font-awesome.min.css">

  <!-- Ionicons -->
  <link rel="stylesheet" href="view/bower_components/Ionicons/css/ionicons.min.css">

  <!-- Icommons -->
  <link rel="stylesheet" href="view/bower_components/icommons/css/font-icomoons.css">

  <!-- Theme style -->
  <link rel="stylesheet" href="view/dist/css/AdminLTE.css">

  <!-- AdminLTE Skins -->
  <link rel="stylesheet" href="view/dist/css/skins/_all-skins.min.css">

  <!-- estilos propios -->
  <link rel="stylesheet" href="view/css/styles.css">

  <!-- Google Font -->
  <link href="https://fonts.googleapis.com/css?family=Poppins:300,300i,400,400i,500,500i,600i,700,700i,800,800i" rel="stylesheet">

  <!--=============================================
  =            plugin de javascript            =
  ============================================= -->
  <!-- jQuery 3 -->
  <script src="view/bower_components/jquery/dist/jquery.min.js"></script>
  
  <!-- Bootstrap 3.3.7 -->
  <script src="view/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

  <!-- SlimScroll -->
  <script src="view/bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
  
  <!-- FastClick -->
  <script src="view/bower_components/fastclick/lib/fastclick.js"></script>
  
  <!-- AdminLTE App -->
  <script src="view/dist/js/adminlte.min.js"></script>
  
  <!-- AdminLTE for demo purposes -->
  <script src="view/dist/js/demo.js"></script>

  <!-- DataTables -->
<script src="view/bower_components/datatables.net/js/jquery.dataTables.min.js"></script>
<script src="view/bower_components/datatables/js/dataTables.bootstrap.min.js"></script>
<script src="view/bower_components/datatables/js/dataTables.responsive.min.js"></script>
<script src="view/bower_components/datatables/js/responsive.bootstrap.min.js"></script>

<!-- Sweetalert 2 -->
  <script src="view/plugins/sweetalert2/sweetalert2.all.js"></script>
  

   
  <!--=====  End of plugin de javascript   ====== -->
  

</head>
<!-- ============================================= 
              COMPONENTES DEL DOCUMENTO
============================================= -->
<body class="hold-transition login-page skin-blue sidebar-collapse sidebar-mini">



<?php 

if (isset($_SESSION["iniciarSesion"]) && $_SESSION["iniciarSesion"] == "ok") {
// Site wrapper 
echo '<div class="wrapper">';
// Navbar menu
include "modulos/navbar.php";
// Sidebar menu
include "modulos/sidebar.php";
// contenido

if (isset($_GET["ruta"])) {
  if ($_GET["ruta"] == "dashboard" ||
      $_GET["ruta"] == "rol" || 
      $_GET["ruta"] == "usuarios" ||
      $_GET["ruta"] == "permisos" || 
      $_GET["ruta"] == "sexo" ||
      $_GET["ruta"] == "recaudo-pradera" ||
      $_GET["ruta"] == "recaudo-costarica" ||
      $_GET["ruta"] == "recaudo-buga" ||
      $_GET["ruta"] == "recaudo-candelaria" ||
      $_GET["ruta"] == "recaudo-rozo" ||
      $_GET["ruta"] == "recaudo-tulua" ||
      $_GET["ruta"] == "recaudo-cartago" ||
      $_GET["ruta"] == "recaudo-florida" ||
      $_GET["ruta"] == "marcadas-pradera" ||
      $_GET["ruta"] == "marcadas-costarica" ||
      $_GET["ruta"] == "marcadas-buga" ||
      $_GET["ruta"] == "marcadas-candelaria" ||
      $_GET["ruta"] == "marcadas-rozo" ||
      $_GET["ruta"] == "marcadas-tulua" ||
      $_GET["ruta"] == "marcadas-cartago" ||
      $_GET["ruta"] == "marcadas-florida" ||
      $_GET["ruta"] == "rodamiento-pradera" ||
      $_GET["ruta"] == "rodamiento-costarica" ||
      $_GET["ruta"] == "rodamiento-buga" ||
      $_GET["ruta"] == "rodamiento-candelaria" ||
      $_GET["ruta"] == "rodamiento-rozo" ||
      $_GET["ruta"] == "rodamiento-tulua" ||
      $_GET["ruta"] == "rodamiento-cartago" ||
      $_GET["ruta"] == "rodamiento-florida" ||
      $_GET["ruta"] == "descuentos-pradera" ||
      $_GET["ruta"] == "descuentos-costarica" ||
      $_GET["ruta"] == "descuentos-buga" ||
      $_GET["ruta"] == "descuentos-candelaria" ||
      $_GET["ruta"] == "descuentos-rozo" ||
      $_GET["ruta"] == "descuentos-tulua" ||
      $_GET["ruta"] == "descuentos-cartago" ||
      $_GET["ruta"] == "descuentos-florida" ||
      $_GET["ruta"] == "vehiculos-pradera" ||
      $_GET["ruta"] == "vehiculos-costarica" ||
      $_GET["ruta"] == "vehiculos-buga" ||
      $_GET["ruta"] == "vehiculos-candelaria" ||
      $_GET["ruta"] == "vehiculos-rozo" ||
      $_GET["ruta"] == "vehiculos-tulua" ||
      $_GET["ruta"] == "vehiculos-cartago" ||
      $_GET["ruta"] == "vehiculos-florida" ||
      $_GET["ruta"] == "reportes-rodamiento-pradera" ||
      $_GET["ruta"] == "reportes-rodamiento-costarica" ||
      $_GET["ruta"] == "reportes-rodamiento-buga" ||
      $_GET["ruta"] == "reportes-rodamiento-candelaria" ||
      $_GET["ruta"] == "reportes-rodamiento-rozo" ||
      $_GET["ruta"] == "reportes-rodamiento-tulua" ||
      $_GET["ruta"] == "reportes-rodamiento-cartago" ||
      $_GET["ruta"] == "reportes-rodamiento-florida" ||
      $_GET["ruta"] == "reportes-recaudos-pradera" ||
      $_GET["ruta"] == "reportes-recaudos-costarica" ||
      $_GET["ruta"] == "reportes-recaudos-buga" ||
      $_GET["ruta"] == "reportes-recaudos-candelaria" ||
      $_GET["ruta"] == "reportes-recaudos-rozo" ||
      $_GET["ruta"] == "reportes-recaudos-tulua" ||
      $_GET["ruta"] == "reportes-recaudos-cartago" ||
      $_GET["ruta"] == "reportes-recaudos-florida" ||
      $_GET["ruta"] == "reportes-marcadas-pradera" ||
      $_GET["ruta"] == "reportes-marcadas-costarica" ||
      $_GET["ruta"] == "reportes-marcadas-buga" ||
      $_GET["ruta"] == "reportes-marcadas-candelaria" ||
      $_GET["ruta"] == "reportes-marcadas-rozo" ||
      $_GET["ruta"] == "reportes-marcadas-tulua" ||
      $_GET["ruta"] == "reportes-marcadas-cartago" ||
      $_GET["ruta"] == "reportes-marcadas-florida" ||
      $_GET["ruta"] == "salir"){
      include "modulos/".$_GET["ruta"].".php";
  }else{
    include "modulos/404.php";
  }
}else{
    include "modulos/dashboard.php";
  }
// Footer
include "modulos/footer.php";

echo '</div>';
//wrapper
}else{
  include "modulos/login.php";
}
?>


<script src="view/js/plantilla.js"></script>
<script src="view/js/rol.js"></script>
<script src="view/js/sexo.js"></script>
</body>
</html>
