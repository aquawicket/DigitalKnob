<?php
header('Access-Control-Allow-Origin: *');
include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/DK.php");

##################################################################################
# dk_realpath(path) -> rtn_var
#
#    PHP: https://www.php.net/manual/en/function.realpath.php
#
function dk_realpath(){
	#dk_debugFunc();
	echo "###### ".__FUNCTION__."(".implode(";", func_get_args()).") ######\n";

	$argv = func_get_args();
	$path = $argv[0];
	echo "path = ${path}\n";

	echo realpath($path)."\n";
	return realpath($path);

}







####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
function DKTEST(){ 
	#dk_debugFunc();
	
	echo dk_realpath("notepad.exe");

}

?>