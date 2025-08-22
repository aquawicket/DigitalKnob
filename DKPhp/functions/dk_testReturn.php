<?php
##################################################################################
# dk_testReturn(input, output)
#
function dk_testReturn($input, &...$rtn_var){
	#dk_debugFunc(1, 2);
	global $dk_testReturn;						### Result as global variable


	$dk_testReturn = str_replace("input", "output", "$input");
	
	
	### output ####
	if(isset($rtn_var[0])){
		$rtn_var[0] = $dk_testReturn;			### Result as parameter variable
	} elseif(isset($dk_testReturn)){
		echo("$dk_testReturn\n");				### Result as stdout
	}
	return $dk_testReturn;						### Result as return value
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(!function_exists('DKTEST')){ function DKTEST() {
	#dk_debugFunc(0);
	dk_source("dk_echo");
	
	### Result as global variable 						[GLOBAL]
	dk_echo("\n");
	dk_testReturn("inputA");
	dk_echo("dk_testReturn = ".$GLOBALS['dk_testReturn']."\n");
	
	### Result as parameter variable 					[GLOBAL][PARAM]
	dk_echo("\n");
	$resultB = "";
	dk_testReturn("inputB", $resultB);
	dk_echo("resultB = $resultB\n");
	dk_echo("dk_testReturn = ".$GLOBALS['dk_testReturn']."\n");
	
	### Result as return value 							[GLOBAL][RETURN]
	dk_echo("\n");
	$resultC=dk_testReturn("inputC");
	dk_echo("resultC = $resultC\n");
	dk_echo("dk_testReturn = ".$GLOBALS['dk_testReturn']."\n");
	
	### Result as return value and parameter variable 	[GLOBAL][PARAM][RETURN]
	dk_echo("\n");
	$resultD = "";
	$resultE=dk_testReturn("inputDE", $resultD);
	dk_echo("resultD = $resultD\n");
	dk_echo("resultE = $resultE\n");
	dk_echo("dk_testReturn = ".$GLOBALS['dk_testReturn']."\n");
	
	### Result from stdout								[STDOUT]
	dk_echo("\n");
	$PHP_EXE = "C:\Users\Administrator\DigitalKnob\DKTools\php-src-php-8.4.11-win32-vs17-x64\php.exe";
	$resultF = "";
	$exit_code = -1;
	putenv("DKTEST=OFF");
	exec("$PHP_EXE dk_testReturn.php inputF", $resultF, $exit_code);
	dk_echo("resultF = ".end($resultF)."\n");
	dk_echo("exit_code = $exit_code\n");
}}




include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/DigitalKnob/Development/DKPhp/functions/DK.php");
?>
