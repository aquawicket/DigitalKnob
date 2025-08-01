<?php

##################################################################################
# dk_testReturn(input, output)
#
function dk_testReturn(){
	#dk_debugFunc 1 2

	if(!isset($argv)){
		$argv = func_get_args();
	}
	if(isset($argv[0])){
		global $dk_testReturn; $dk_testReturn = str_replace("input", "output", "$argv[0]");
	}
	
	if(isset($argv[1])){
		global ${$argv[1]}; ${$argv[1]} = $dk_testReturn;
	} else {
		dk_echo("$dk_testReturn\n");
	}
	
	return 0;
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(!function_exists('DKTEST')){ function DKTEST() {
	#dk_call dk_debugFunc 0

	include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/DigitalKnob/Development/DKPhp/functions/dk_echo.php");
	
	### Result as global variable
	dk_echo("\n");
	dk_testReturn("inputA");
	dk_echo("dk_testReturn = ".$GLOBALS['dk_testReturn']."\n");
	
	### Result as parameter
	dk_echo("\n");
	dk_testReturn("inputB", "resultB");
	dk_echo("resultB = ".$GLOBALS['resultB']."\n");
	dk_echo("dk_testReturn = ".$GLOBALS['dk_testReturn']."\n");
	
	### Result as return value
#	dk_echo("\n");
#	$resultC=`dk_testReturn("inputC")`;
#	dk_echo "resultC = ${resultC}";
#	dk_echo("dk_testReturn = ".$GLOBALS['dk_testReturn']."\n");
}}




include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/DigitalKnob/Development/DKPhp/functions/DK.php");
?>
