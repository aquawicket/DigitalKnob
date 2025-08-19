<?php

##################################################################################
# dk_basename(_path, _rtn_var)
#
#	Strip directory and suffix from filenames
#
#	Reference: https://en.wikipedia.org/wiki/Basename
#
function dk_basename() {
	#dk_debugFunc(1 2);
	if(!isset($argv)){ $argv = func_get_args(); }
	
	# $argv[0] = _path;
	# $argv[1] = _rtn_var;
	
	$GLOBALS["dk_basename"] = basename($argv[0], "");
	return $GLOBALS["dk_basename"];
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(!function_exists('DKTEST')){ function DKTEST() {
	#dk_debugFunc 0
	include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/DigitalKnob/Development/DKPhp/functions/dk_echo.php");
	
	### Result as global variable
	dk_echo("\n");
	dk_basename("A:/directoryA/filenameA.extA");
	dk_echo("dk_basename = ".$GLOBALS["dk_basename"]."\n");
	
	### Result as variable parameter
#	dk_echo("\n");
#	dk_basename("B:/directoryB/filenameB.extB", resultB);
#	dk_echo("resultB = ${resultB}");
#	dk_echo("dk_basename = ".$GLOBALS["dk_basename"]."\n");
	
	### Result as return value
	dk_echo("\n");
	$resultC = dk_basename("C:/directoryC/filenameC.extC");
	dk_echo("resultC = ${resultC}\n");
	dk_echo("dk_basename = ".$GLOBALS["dk_basename"]."\n");
	
	### Result as hashtable parameter
#	dk_echo("\n");
#	dk_echo("\n");
#	dk_basename("D:/directoryD/filenameD.extD", resultD[value]);
#	dk_echo("resultD[value] = ${resultD[value]}");
#	dk_echo("dk_basename = ".$GLOBALS["dk_basename"]."\n");
	
}}


include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/DigitalKnob/Development/DKPhp/functions/DK.php");
?>