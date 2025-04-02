<?php

################################################################################
# dk_debug(message)
#
#    Print a debug message to the console
#
#    @message - The message to print
#
function dk_debug() {
	#dk_debugFunc(1);
	include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/dk_log.php");
	
	if(!isset($argv)){
		$argv = func_get_args();
	}
	
    dk_log("DEBUG", $argv[0]);
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function DKTEST() {
	#dk_debugFunc(0);

    dk_debug("test dk_debug message");
}


include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/DK.php");
?>