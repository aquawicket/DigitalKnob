<?php
header('Access-Control-Allow-Origin: *');
include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/DK.php");

##################################################################################
# __TEMPLATE__()
#
function __TEMPLATE__(){
	#dk_debugFunc
	echo "###### ".__FUNCTION__."(".implode(";", func_get_args()).") ######\n";

	$argv = func_get_args();

	//TODO
	return 0;
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function DKTEST() { 
	#dk_debugFunc 0

	__TEMPLATE__(123, "abc");

}
