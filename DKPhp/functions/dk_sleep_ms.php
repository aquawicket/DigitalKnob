<?php

#####################################################################
# dk_sleep_ms(milliseconds)
#
function dk_sleep_ms() {
	#dk_debugFunc(1);
	
	$argv = func_get_args();
	$milliseconds = $argv[0] * 1000;
	usleep($milliseconds);
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(!function_exists('DKTEST')){ function DKTEST() {
	#dk_debugFunc(0);

	include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/dk_echo.php");
    dk_echo("sleeping for 5000 milliseconds . . .");
    dk_sleep_ms(5000);
}}


include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/DK.php");
?>
