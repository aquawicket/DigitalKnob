#!/usr/bin/php
<?php

################################################################################
# dk_info(message)
#
#    Print a info message to the console
#
#    @message - The message to print
#
function dk_info() {
	#dk_debugFunc(1);
	dk_source("dk_log");
	
	if(!isset($argv)){
		$argv = func_get_args();
	}
	
    dk_log("INFO", $argv[0]);
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(!function_exists('DKTEST')){ function DKTEST() {
	#dk_debugFunc 0

    dk_info("test dk_info message");
}}


include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/Digital Knob/Development/DKPhp/functions/DK.php");
?>