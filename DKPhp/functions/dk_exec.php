<?php

##################################################################################
# dk_exec()
#
function dk_exec(){
	#dk_debugFunc
	echo "###### ".__FUNCTION__."(".implode(";", func_get_args()).") ######\n";

	if(!isset($argv)){
		$argv = func_get_args();
	}

	$output=null;
	$retval=null;
	exec($argv[0], $output, $retval);
	
	echo($output[1]);
	
	return $retval;
}














###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(!function_exists('DKTEST')){ function DKTEST() {
	#dk_debugFunc 0

	dk_exec("ver");
}}


include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/DK.php");
?>