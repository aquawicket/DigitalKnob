<?php

##################################################################################
# dk_chdir()
#
function dk_chdir(){
	#dk_debugFunc
	#echo "###### ".__FUNCTION__."(".implode(";", func_get_args()).") ######\n";

	if(!isset($argv)){
		$argv = func_get_args();
	}

	#echo getcwd() . "\n";
	$ret = chdir("$argv[0]");
	#echo getcwd() . "\n";
	return $ret;
}














###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(!function_exists('DKTEST')){ function DKTEST() {
	#dk_debugFunc 0

	dk_chdir("C:/Windows/System32");
}}


include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/DK.php");
?>