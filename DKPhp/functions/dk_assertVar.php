<?php
header('Access-Control-Allow-Origin: *');
include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/DK.php");


##################################################################################
# dk_assertVar()
#
function dk_assertVar(){
	#dk_debugFunc
	echo "###### ".__FUNCTION__."(".implode(";", func_get_args()).") ######\n";
	$argv = func_get_args();
	if(isset($argv[0])){
		//return 0;
	}
	echo "${$argv[0]}";
	if(isset(${$argv[0]})){
		return 0;
	}
	//TODO
	echo "dk_fatal(ASSERTION: dk_assertVar(%*): $argv[0] not defined)\n";
	return -1;
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function DKTEST() { 
	#dk_debugFunc 0

	$testVar = "abc123";
	dk_assertVar($testVar);
	dk_assertVar("testVar");
	dk_assertVar("nonexistent");
	
	//dk_assertVar($nonexistent);
}
