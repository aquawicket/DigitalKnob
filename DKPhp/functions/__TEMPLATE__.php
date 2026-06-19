#!/usr/bin/php
<?php

##################################################################################
# __TEMPLATE__(input, rtn_var)
#
function __TEMPLATE__($input, &...$rtn_var){
	#dk_debugFunc 1 2
	global $__TEMPLATE__;						### Result as global variable


	$__TEMPLATE__ = $input;  # Replace all occurences of __TEMPLATE__ with the "FunctionName" and Replace this line with your code.
	
	
	###### return ######
	if(isset($rtn_var[0])){
		$rtn_var[0] = $__TEMPLATE__;			### Result as parameter variable
	} elseif(isset($__TEMPLATE__)){
		echo("$__TEMPLATE__\n");				### Result as stdout
	}
	return $__TEMPLATE__;						### Result as return value
}













###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(!function_exists('DKTEST')){ function DKTEST() {
	#dk_debugFunc(0);
	dk_source("dk_echo");
	
	### Result as global variable
	dk_echo("\n");
	__TEMPLATE__("inputA");
	dk_echo("__TEMPLATE__ = ".$GLOBALS['__TEMPLATE__']."\n");
	
	### Result as parameter variable
	dk_echo("\n");
	$resultB = "";
	__TEMPLATE__("inputB", $resultB);
	dk_echo("resultB = $resultB\n");
	dk_echo("__TEMPLATE__ = ".$GLOBALS['__TEMPLATE__']."\n");
	
	### Result as return value
	dk_echo("\n");
	$resultC=__TEMPLATE__("inputC");
	dk_echo("resultC = $resultC\n");
	dk_echo("__TEMPLATE__ = ".$GLOBALS['__TEMPLATE__']."\n");
	
	### Result as return value and parameter variable
	dk_echo("\n");
	$resultD = "";
	$resultE=__TEMPLATE__("inputDE", $resultD);
	dk_echo("resultD = $resultD\n");
	dk_echo("resultE = $resultE\n");
	dk_echo("__TEMPLATE__ = ".$GLOBALS['__TEMPLATE__']."\n");
	
	### Result as stdout
	# TODO
}}




include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/Digital Knob/Development/DKPhp/functions/DK.php");
?>