<?php

################################################################################
# dk_verbose(message)
#
#    Print a verbose message to the console
#
#    @message - The message to print
#
function dk_verbose() {
	#dk_debugFunc(1);
	include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/dk_log.php");
	
	if(!isset($argv)){
		$argv = func_get_args();
	}
	
    dk_log("VERBOSE", $argv[0]);
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function DKTEST() {
	#dk_infoFunc(0);

    dk_verbose("test dk_verbose message");
}


include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/DK.php");
?>