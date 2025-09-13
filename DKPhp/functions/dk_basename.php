<?php

##################################################################################
# dk_basename(_path, _rtn_var)
#
#	Strip directory and suffix from filenames
#
#	Reference: https://en.wikipedia.org/wiki/Basename
#
function dk_basename($_path, &...$rtn_var){
	#dk_debugFunc(1 2);
	global $dk_basename;
	
	
	$dk_basename = basename($_path, "");
	
	
	### output ####
	if(isset($rtn_var[0])){
		$rtn_var[0] = $dk_basename;
	} elseif(isset($dk_basename)){
		echo("$dk_basename\n");
	}
	return $dk_basename;
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(!function_exists('DKTEST')){ function DKTEST() {
	#dk_debugFunc(0);
	dk_source("dk_echo");
	
	### Result as global variable
	dk_echo("\n");
	dk_echo($GLOBALS['lblack']."dk_basename(\"A:/directoryA/filenameA.extA\");".$GLOBALS['clr']."\n");
	dk_basename("A:/directoryA/filenameA.extA");
	dk_echo("dk_basename = ".$GLOBALS['dk_basename']."\n");
	
	### Result as parameter variable
	dk_echo("\n");
	dk_echo($GLOBALS['lblack']."dk_basename(\"B:/directoryB/filenameB.extB\", \$resultB);".$GLOBALS['clr']."\n");
	$resultB = "";
	dk_basename("B:/directoryB/filenameB.extB", $resultB);
	dk_echo("resultB = $resultB\n");
	dk_echo("dk_basename = ".$GLOBALS['dk_basename']."\n");
	
	### Result as return value
	dk_echo("\n");
	dk_echo($GLOBALS['lblack']."\$resultC=dk_basename(\"C:/directoryC/filenameC.extC\");".$GLOBALS['clr']."\n");
	$resultC=dk_basename("C:/directoryC/filenameC.extC");
	dk_echo("resultC = $resultC\n");
	dk_echo("dk_basename = ".$GLOBALS['dk_basename']."\n");
	
	### Result as return value and parameter variable
	dk_echo("\n");
	dk_echo($GLOBALS['lblack']."\$resultD2=dk_basename(\"D:/directoryD/filenameD.extD\", \$resultD1);".$GLOBALS['clr']."\n");
	$resultD1 = "";
	$resultD2=dk_basename("D:/directoryD/filenameD.extD", $resultD1);
	dk_echo("resultD1 = $resultD1\n");
	dk_echo("resultD2 = $resultD2\n");
	dk_echo("dk_basename = ".$GLOBALS['dk_basename']."\n");
}}


include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/DigitalKnob/Development/DKPhp/functions/DK.php");
?>