<?php

##################################################################################
# dk_fileContains(_path, _string, rtn_var)
#
function dk_fileContains($_path, $_string, &...$rtn_var){
	#dk_debugFunc 1 2
	global $dk_fileContains;

	
	if(strpos(file_get_contents("{$_path}"), "$_string")) {
		$dk_fileContains = '1';
	} else {
		$dk_fileContains = '0';
	}
	
#	if (is_bool($dk_fileContains)) {
#		$dk_fileContains = $dk_fileContains ? 'true' : '0';
#	}
	
	### output ####
	if(isset($rtn_var[0])){
		$rtn_var[0] = $dk_fileContains;
	} elseif(isset($dk_fileContains)){
		echo("$dk_fileContains\n");
	}
	return $dk_fileContains;
}













###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(!function_exists('DKTEST')){ function DKTEST() {
	#dk_debugFunc(0);
	dk_source("dk_echo");
	
	### Result as global variable
	dk_echo("\n");
	dk_fileContains($GLOBALS['DKSCRIPT_DIR']."/DK.php", "php");
	dk_echo("dk_fileContains = ".$GLOBALS['dk_fileContains']."\n");
	
	### Result as parameter variable
	dk_echo("\n");
	$resultB = "";
	dk_fileContains($GLOBALS['DKSCRIPT_DIR']."/DK.php", "noneExistent", $resultB);
	dk_echo("resultB = $resultB\n");
	dk_echo("dk_fileContains = ".$GLOBALS['dk_fileContains']."\n");
	
	### Result as return value
	dk_echo("\n");
	$resultC=dk_fileContains($GLOBALS['DKSCRIPT_DIR']."/DK.php", "php");
	dk_echo("resultC = $resultC\n");
	dk_echo("dk_fileContains = ".$GLOBALS['dk_fileContains']."\n");
	
	### Result as return value and parameter variable
	dk_echo("\n");
	$resultD = "";
	$resultE=dk_fileContains($GLOBALS['DKSCRIPT_DIR']."/DK.php", "noneExistent", $resultD);
	dk_echo("resultD = $resultD\n");
	dk_echo("resultE = $resultE\n");
	dk_echo("dk_fileContains = ".$GLOBALS['dk_fileContains']."\n");
	
	### Result as conditional value
	dk_echo("\n");
	if(dk_fileContains($GLOBALS['DKSCRIPT_DIR']."/DK.php", "php")){
		echo "TRUE\n";
	} else {
		echo "FALSE\n";
	}
	dk_echo("dk_fileContains = ".$GLOBALS['dk_fileContains']."\n");
	
	dk_echo("\n");
	if(dk_fileContains($GLOBALS['DKSCRIPT_DIR']."/DK.php", "noneExistentnoneExistent")){
		echo "TRUE\n";
	} else {
		echo "FALSE\n";
	}
	dk_echo("dk_fileContains = ".$GLOBALS['dk_fileContains']."\n");
	
	### Result as stdout
	# TODO
}}




include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/DigitalKnob/Development/DKPhp/functions/DK.php");
?>