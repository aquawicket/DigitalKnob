<?php

################################################################################
# dk_dirname(<pathname>, <rtn_var>:optional)
#
#   Returns a parent directory's path 
#
#   Reference: https://en.wikipedia.org/wiki/Dirname
#
function dk_dirname() {
	#dk_debugFunc(1 2);
	
	if(!isset($argv)){
		$argv = func_get_args();
	}
	
	return dirname($argv[0]);
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(!function_exists('DKTEST')){ function DKTEST() {
	#dk_debugFunc(0);
	include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/dk_echo.php");
	
    $myPath = "C:/Windows/System32";
    $dk_dirname = dk_dirname("$myPath");
    dk_echo("myPath:'$myPath' -> dk_dirname:'$dk_dirname'\n");
	
	$myPath="C:/Windows/System32/";
    $dk_dirname = dk_dirname("$myPath");
	dk_echo("myPath:'$myPath' -> dk_dirname:'$dk_dirname'\n");
	
	$myPath="C:\\Windows\\System32";
    $dk_dirname = dk_dirname("$myPath");
	dk_echo("myPath:'$myPath' -> dk_dirname:'$dk_dirname'\n");
	
	$myPath="C:\\Windows\\System32\\";
    $dk_dirname = dk_dirname("$myPath");
	dk_echo("myPath:'$myPath' -> dk_dirname:'$dk_dirname'\n");
	
	# FIXME
	$myPath="/home/aquawicket/docs/.";
    $dk_dirname = dk_dirname("$myPath");
	dk_echo("myPath:'$myPath' -> dk_dirname:'$dk_dirname'\n");
	
	$myPath="/home/aquawicket/docs/";
    $dk_dirname = dk_dirname("$myPath");
	dk_echo("myPath:'$myPath' -> dk_dirname:'$dk_dirname'\n");
	
	$myPath="base.wiki";
    $dk_dirname = dk_dirname("$myPath");
	dk_echo("myPath:'$myPath' -> dk_dirname:'$dk_dirname'\n");
	
	# FIXME
	#$myPath="/";
    #$dk_dirname = dk_dirname("$myPath");
	#dk_echo("myPath:'$myPath' -> dk_dirname:'$dk_dirname'\n");
}}


include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/DK.php");
?>