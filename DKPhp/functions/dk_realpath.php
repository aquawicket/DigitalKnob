<?php
header('Access-Control-Allow-Origin: *');
include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/DK.php");

##################################################################################
# dk_realpath(path) -> rtn_var
#
#    PHP: https://www.php.net/manual/en/function.realpath.php
#
function dk_realpath($path){
	echo "dk_realpath()\n";
	#dk_debugFunc();
#   if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }	
	
	$_realpath_ = realpath($path);
	dk_printVar($_realpath_);
	return $_realpath_;
}







####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
#function DKTEST(){ 
	#dk_debugFunc();
	
	#$realpath = dk_realpath("bash");
#	dk_info("realpath = $realpath");
#}

?>