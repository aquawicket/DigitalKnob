<?php

####################################################################
# dk_sleep(seconds)
#
function dk_sleep() {
	#dk_debugFunc(1);

	$argv = func_get_args();
	sleep($argv[0]);
}









###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(!function_exists('DKTEST')){ function DKTEST() {
	#dk_debugFunc(0);

	include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/dk_echo.php");
    dk_echo("sleeping for 5 seconds . . .");
    dk_sleep(5);
}}


include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/DK.php");
?>