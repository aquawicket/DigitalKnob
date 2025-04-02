<?php

################################################################################
# dk_fatal(message)
#
#    Print a fatal message to the console
#
#    @message - The message to print
#
function dk_fatal() {
	#dk_debugFunc(1);
	include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/dk_log.php");
	
	if(!isset($argv)){
		$argv = func_get_args();
	}
	
    dk_log("FATAL", $argv[0]);
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function DKTEST() {
	#dk_debugFunc(0);

    dk_fatal("test dk_fatal message");
}


include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/DK.php");
?>