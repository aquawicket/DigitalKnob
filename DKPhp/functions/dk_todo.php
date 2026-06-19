#!/usr/bin/php
<?php

################################################################################
# dk_todo(message)
#
#    Print a todo message to the console
#
#    @message - The message to print
#
function dk_todo() {
	#dk_debugFunc(1);
	dk_source("dk_log");
	
	if(!isset($argv)){
		$argv = func_get_args();
	}
	
    dk_log("TODO", $argv[0]);
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(!function_exists('DKTEST')){ function DKTEST() {
	#dk_debugFunc 0

    dk_todo("test dk_todo message");
}}


include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/Digital Knob/Development/DKPhp/functions/DK.php");
?>