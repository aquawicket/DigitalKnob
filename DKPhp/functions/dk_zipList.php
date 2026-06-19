#!/usr/bin/php
<?php

##################################################################################
# dk_zipList(zip_file, _rtn_var)
#
#	DESCRIPTION
#
#
function dk_zipList($zip_file, &...$rtn_var){
	#dk_debugFunc(0 99);
	global $dk_zipList;

	$za = new ZipArchive(); 
	$za->open($zip_file); 
	for( $i = 0; $i < $za->numFiles; $i++ ) { 
		$stat = $za->statIndex( $i ); 
		print_r( basename( $stat['name'] ) . PHP_EOL ); 
	}

	$dk_zipList = "your code here";

	
	###### return ######
	if(isset($rtn_var[0])){
		$rtn_var[0] = $dk_zipList;
	} elseif(isset($dk_zipList)){
		echo("$dk_zipList\n");
	}
	return $dk_zipList;
}











###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(!function_exists('DKTEST')){ function DKTEST() {
	#dk_debugFunc(0);
	dk_source("dk_echo");

	### Result as global variable
	dk_echo("\n");
	dk_zipList("C:/Users/Administrator/Digital Knob/download/BatchLibrary-master.zip");
	dk_echo("dk_zipList = ".$GLOBALS['dk_zipList']."\n");

#	### Result as parameter variable
#	dk_echo("\n");
#	$resultB = "";
#	dk_zipList("B:/directoryB/filenameB.extB", $resultB);
#	dk_echo("resultB = $resultB\n");
#	dk_echo("dk_zipList = ".$GLOBALS['dk_zipList']."\n");
#
#	### Result as return value
#	dk_echo("\n");
#	$resultC=dk_zipList("C:/directoryC/filenameC.extC");
#	dk_echo("resultC = $resultC\n");
#	dk_echo("dk_zipList = ".$GLOBALS['dk_zipList']."\n");
#
#	### Result as return value and parameter variable
#	dk_echo("\n");
#	$resultD1 = "";
#	$resultD2=dk_zipList("D:/directoryD/filenameD.extD", $resultD1);
#	dk_echo("resultD1 = $resultD1\n");
#	dk_echo("resultD2 = $resultD2\n");
#	dk_echo("dk_zipList = ".$GLOBALS['dk_zipList']."\n");
}}


include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/Digital Knob/Development/DKPhp/functions/DK.php");
?>
