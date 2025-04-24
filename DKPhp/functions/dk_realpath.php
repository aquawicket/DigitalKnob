<?php
<<<<<<< HEAD
header('Access-Control-Allow-Origin: *');
include("DK.php");
#include(${DKPHP_FUNCTIONS_DIR}/DK.php)
#include_guard()
=======
>>>>>>> Development

##################################################################################
# dk_realpath(path) -> rtn_var
#
#    PHP: https://www.php.net/manual/en/function.realpath.php
#
<<<<<<< HEAD
function dk_realpath($path){
	echo "dk_realpath()\n";
	#dk_debugFunc();
#   if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }	
	
	$_realpath_ = realpath($path);
	dk_printVar($_realpath_);
	return $_realpath_;
=======
function dk_realpath(){
	#dk_debugFunc();
	echo "###### ".__FUNCTION__."(".implode(";", func_get_args()).") ######\n";

	$argv = func_get_args();
	$path = $argv[0];
	echo "path = ${path}\n";

	echo realpath($path)."\n";
	return realpath($path);

>>>>>>> Development
}







<<<<<<< HEAD
####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
#function DKTEST(){ 
	#dk_debugFunc();
	
	#$realpath = dk_realpath("bash");
#	dk_info("realpath = $realpath");
#}

=======
###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(!function_exists('DKTEST')){ function DKTEST() {
	#dk_debugFunc();
	
	echo dk_realpath("notepad.exe");
}}


include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/DK.php");
>>>>>>> Development
?>