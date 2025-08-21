<?php

##################################################################################
# dk_pause(pause_msg)
#
#
function dk_pause(){
	#dk_debugFunc(0, 1);
	
	$argv = func_get_args();
	if(empty($argv[0])){ $pause_msg="Press any key to continue..."; } else { $pause_msg="$argv[0]"; }
	if(!empty($pause_msg)){ dk_source("dk_echo"); dk_echo("$pause_msg"); }
	
	$handle = fopen ("php://stdin","r");
    do { $line = fgets($handle); } while ($line == '');
    fclose($handle);
    return $line;
}













###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(!function_exists('DKTEST')){ function DKTEST() {
	#dk_debugFunc(0);
	
	dk_source("dk_echo"); 
	dk_echo("Pause with default message\n");
    dk_pause();
    dk_pause("Pause with a custom message");
    dk_pause($GLOBALS['red']."Pause ".$GLOBALS['green']."with ".$GLOBALS['blue']."colorful ".$GLOBALS['yellow']."message".$GLOBALS['clr']);
    dk_echo("Pause with no message\n");
    dk_pause(" ");
}}




include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/DigitalKnob/Development/DKPhp/functions/DK.php");
?>