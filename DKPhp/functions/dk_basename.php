<?php

################################################################################
# dk_basename(<pathname>, <rtn_var>:optional)
#
#	Strip directory and suffix from filenames
#
#	Reference: https://en.wikipedia.org/wiki/Basename
#
function dk_basename() {
	#dk_debugFunc(1 2);
	
	if(!isset($argv)){
		$argv = func_get_args();
	}
	
	return basename($argv[0], "");
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(!function_exists('DKTEST')){ function DKTEST() {
	#dk_debugFunc 0
	include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/dk_echo.php");
	
	$myPath="C:/Windows/System32/test.v123.zip";
	$dk_basename = dk_basename("$myPath");
	dk_echo("myPath:'$myPath' -> dk_basename:'$dk_basename'\n");

	dk_echo("\n");
	$myPath="TEST";
	$dk_basename = dk_basename("$myPath");
	dk_echo("myPath:'$myPath' -> dk_basename:'$dk_basename'\n");

	dk_echo("\n");
	$myPath="https://ia802200.us.archive.org/22/items/windows-7-pesuper-lite-50-mb/Windows7PESuper%20Lite50MB.iso";
	$dk_basename = dk_basename("$myPath");
	dk_echo("myPath:'$myPath' -> dk_basename:'$dk_basename'\n");

	dk_echo("\n");
	$myPath="C:/Windows/System32/test.v123.zip";
	$dk_basename = dk_basename("$myPath");
	dk_echo("myPath:'$myPath' -> dk_basename:'$dk_basename'\n");

	dk_echo("\n");
	$myPath="TEST";
	$dk_basename = dk_basename("$myPath");
	dk_echo("myPath:'$myPath' -> dk_basename:'$dk_basename'\n");

	dk_echo("\n");
	$myPath="https://ia802200.us.archive.org/22/items/windows-7-pesuper-lite-50-mb/Windows7PESuper%20Lite50MB.iso";
	$dk_basename = dk_basename("$myPath");
	dk_echo("myPath:'$myPath' -> dk_basename:'$dk_basename'\n");
}}


include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/DK.php");
?>