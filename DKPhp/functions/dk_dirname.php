<?php

################################################################################
# dk_dirname(_path, rtn_var)
#
#   Returns a parent directory's path 
#
#   Reference: https://en.wikipedia.org/wiki/Dirname
#
function dk_dirname($_path, &...$rtn_var) {
	#dk_debugFunc(1 2);
	global $dk_dirname;
	
	
	$dk_dirname = dirname($_path);
	
	
	### output ####
	if(isset($rtn_var[0])){
		$rtn_var[0] = $dk_dirname;
	} elseif(isset($dk_dirname)){
		echo("$dk_dirname\n");
	}
	return $dk_dirname;
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(!function_exists('DKTEST')){ function DKTEST() {
	#dk_debugFunc(0);
	dk_source("dk_echo");
	
	### Result as global variable
	dk_echo("\n");
	dk_dirname("A:/directoryA/filenameA.extA");
	dk_echo("dk_dirname = ".$GLOBALS['dk_dirname']."\n");
	
	### Result as parameter variable
	dk_echo("\n");
	$resultB = "";
	dk_dirname("B:/directoryB/filenameB.extB", $resultB);
	dk_echo("resultB = $resultB\n");
	dk_echo("dk_dirname = ".$GLOBALS['dk_dirname']."\n");
	
	### Result as return value
	dk_echo("\n");
	$resultC=dk_dirname("C:/directoryC/filenameC.extC");
	dk_echo("resultC = $resultC\n");
	dk_echo("dk_dirname = ".$GLOBALS['dk_dirname']."\n");
	
	### Result as return value and parameter variable
	dk_echo("\n");
	$resultD1 = "";
	$resultD2=dk_dirname("D:/directoryD/filenameD.extD", $resultD1);
	dk_echo("resultD1 = $resultD1\n");
	dk_echo("resultD2 = $resultD2\n");
	dk_echo("dk_dirname = ".$GLOBALS['dk_dirname']."\n");
}}


include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/DigitalKnob/Development/DKPhp/functions/DK.php");
?>