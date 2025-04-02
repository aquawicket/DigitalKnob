<?php

################################################################################
# dk_success(message)
#
#    Print a success message to the console
#
#    @message - The message to print
#
function dk_success() {
	#dk_debugFunc(1);
	include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/dk_log.php");
	
	if(!isset($argv)){
		$argv = func_get_args();
	}
	
    dk_log("SUCCESS", $argv[0]);
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function DKTEST() {
	#dk_infoFunc(0);

    dk_success("test dk_success message");
}


include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/DK.php");
?>