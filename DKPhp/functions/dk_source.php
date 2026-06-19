#!/usr/bin/php
<?php

##################################################################################
# dk_source()
#
function dk_source(){
	#dk_debugFunc(1);

	$argv = func_get_args();
	include_once(str_replace("\\", "/", $_SERVER['USERPROFILE'])."/Digital Knob/Development/DKPhp/functions/{$argv[0]}.php");

	return 0;
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(!function_exists('DKTEST')){ function DKTEST() {
	#dk_debugFunc(0);

	dk_source("dk_echo");

}}

include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/Digital Knob/Development/DKPhp/functions/DK.php");
?>