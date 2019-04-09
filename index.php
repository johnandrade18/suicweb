<?php 
require_once "controller/plantilla.controller.php";
require_once "controller/descuentos-buga.controller.php";
require_once "controller/descuentos-candelaria.controller.php";
require_once "controller/descuentos-cartago.controller.php";
require_once "controller/descuentos-costarica.controller.php";
require_once "controller/descuentos-florida.controller.php";
require_once "controller/descuentos-pradera.controller.php";
require_once "controller/descuentos-rozo.controller.php";
require_once "controller/descuentos-tulua.controller.php";
require_once "controller/marcadas-buga.controller.php";
require_once "controller/marcadas-candelaria.controller.php";
require_once "controller/marcadas-cartago.controller.php";
require_once "controller/marcadas-costarica.controller.php";
require_once "controller/marcadas-florida.controller.php";
require_once "controller/marcadas-pradera.controller.php";
require_once "controller/marcadas-rozo.controller.php";
require_once "controller/marcadas-tulua.controller.php";
require_once "controller/recaudo-buga.controller.php";
require_once "controller/recaudo-cartago.controller.php";
require_once "controller/recaudo-candelaria.controller.php";
require_once "controller/recaudo-costarica.controller.php";
require_once "controller/recaudo-florida.controller.php";
require_once "controller/recaudo-pradera.controller.php";
require_once "controller/recaudo-rozo.controller.php";
require_once "controller/recaudo-tulua.controller.php";
require_once "controller/rodamiento-buga.controller.php";
require_once "controller/rodamiento-candelaria.controller.php";
require_once "controller/rodamiento-cartago.controller.php";
require_once "controller/rodamiento-costarica.controller.php";
require_once "controller/rodamiento-florida.controller.php";
require_once "controller/rodamiento-pradera.controller.php";
require_once "controller/rodamiento-rozo.controller.php";
require_once "controller/rodamiento-tulua.controller.php";
require_once "controller/rol.controller.php";
require_once "controller/sexo.controller.php";
require_once "controller/usuarios.controller.php";
require_once "controller/vehiculos-buga.controller.php";
require_once "controller/vehiculos-candelaria.controller.php";
require_once "controller/vehiculos-cartago.controller.php";
require_once "controller/vehiculos-costarica.controller.php";
require_once "controller/vehiculos-florida.controller.php";
require_once "controller/vehiculos-pradera.controller.php";
require_once "controller/vehiculos-rozo.controller.php";
require_once "controller/vehiculos-tulua.controller.php";

require_once "model/descuentos-buga.model.php";
require_once "model/descuentos-candelaria.model.php";
require_once "model/descuentos-cartago.model.php";
require_once "model/descuentos-costarica.model.php";
require_once "model/descuentos-florida.model.php";
require_once "model/descuentos-pradera.model.php";
require_once "model/descuentos-rozo.model.php";
require_once "model/descuentos-tulua.model.php";
require_once "model/marcadas-buga.model.php";
require_once "model/marcadas-candelaria.model.php";
require_once "model/marcadas-cartago.model.php";
require_once "model/marcadas-costarica.model.php";
require_once "model/marcadas-florida.model.php";
require_once "model/marcadas-pradera.model.php";
require_once "model/marcadas-rozo.model.php";
require_once "model/marcadas-tulua.model.php";
require_once "model/recaudo-buga.model.php";
require_once "model/recaudo-cartago.model.php";
require_once "model/recaudo-candelaria.model.php";
require_once "model/recaudo-costarica.model.php";
require_once "model/recaudo-florida.model.php";
require_once "model/recaudo-pradera.model.php";
require_once "model/recaudo-rozo.model.php";
require_once "model/recaudo-tulua.model.php";
require_once "model/rodamiento-buga.model.php";
require_once "model/rodamiento-candelaria.model.php";
require_once "model/rodamiento-cartago.model.php";
require_once "model/rodamiento-costarica.model.php";
require_once "model/rodamiento-florida.model.php";
require_once "model/rodamiento-pradera.model.php";
require_once "model/rodamiento-rozo.model.php";
require_once "model/rodamiento-tulua.model.php";
require_once "model/rol.model.php";
require_once "model/sexo.model.php";
require_once "model/usuarios.model.php";
require_once "model/vehiculos-buga.model.php";
require_once "model/vehiculos-candelaria.model.php";
require_once "model/vehiculos-cartago.model.php";
require_once "model/vehiculos-costarica.model.php";
require_once "model/vehiculos-florida.model.php";
require_once "model/vehiculos-pradera.model.php";
require_once "model/vehiculos-rozo.model.php";
require_once "model/vehiculos-tulua.model.php";

$plantilla = new ControllerPlantilla();

$plantilla -> ctrPlantilla(); 

 ?>