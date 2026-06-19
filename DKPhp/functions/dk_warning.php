#!/usr/bin/php
<?php

################################################################################
# dk_warning(message)
#
#    Print a warning message to the console
#
#    @message - The message to print
#
function dk_warning() {
	#dk_debugFunc(1);
	dk_source("dk_log");
	
	if(!isset($argv)){
		$argv = func_get_args();
	}
	
    dk_log("WARNING", $argv[0]);
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(!function_exists('DKTEST')){ function DKTEST() {
	#dk_debugFunc 0

    dk_warning("test dk_warning message");
}}


include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/Digital Knob/Development/DKPhp/functions/DK.php");
?>