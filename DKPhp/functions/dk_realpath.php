#!/usr/bin/php
<?php

##################################################################################
# dk_realpath(path) -> rtn_var
#
#    PHP: https://www.php.net/manual/en/function.realpath.php
#
function dk_realpath($_path, &...$rtn_var){
	#dk_debugFunc(1 2);
	global $dk_realpath;
	
	
	$dk_realpath = str_replace("\\", "/", realpath($_path));
	
	
	###### return ######
	if(isset($rtn_var[0])){
		$rtn_var[0] = $dk_realpath;
	} elseif(isset($dk_realpath)){
		echo("$dk_realpath\n");
	}
	return $dk_realpath;
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(!function_exists('DKTEST')){ function DKTEST() {
	#dk_debugFunc(0);
	dk_source("dk_echo");
	
	### Result as global variable
	dk_echo("\n");
	dk_realpath("dk_realpath.php");
	dk_echo("dk_realpath = ".$GLOBALS['dk_realpath']."\n");
	
	### Result as parameter variable
	dk_echo("\n");
	$resultB = "";
	dk_realpath("../functions/DK.php", $resultB);
	dk_echo("resultB = $resultB\n");
	dk_echo("dk_realpath = ".$GLOBALS['dk_realpath']."\n");
	
	### Result as return value
	dk_echo("\n");
	$resultC=dk_realpath("../../DKPhp");
	dk_echo("resultC = $resultC\n");
	dk_echo("dk_realpath = ".$GLOBALS['dk_realpath']."\n");
	
	### Result as return value and parameter variable
	dk_echo("\n");
	$resultD1 = "";
	$resultD2=dk_realpath("../../../", $resultD1);
	dk_echo("resultD1 = $resultD1\n");
	dk_echo("resultD2 = $resultD2\n");
	dk_echo("dk_realpath = ".$GLOBALS['dk_realpath']."\n");
}}


include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/Digital Knob/Development/DKPhp/functions/DK.php");
?>