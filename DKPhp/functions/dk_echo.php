<?php
header('Access-Control-Allow-Origin: *');
include_once("DK.php");

##################################################################################
# dk_echo()
#
function dk_echo(){
	#dk_debugFunc();

	$argv = func_get_args();
	$argv_str = implode(";", $argv);
	$argc = func_num_args();

	echo "argc = $argc\n";
	echo "argv = $argv_str\n";
	if($argc > 0){ echo "argv[0] = $argv[0]\n"; }
	if($argc > 1){ echo "argv[1] = $argv[1]\n"; }
	if($argc > 2){ echo "argv[2] = $argv[2]\n"; }
	if($argc > 3){ echo "argv[3] = $argv[3]\n"; }
	if($argc > 4){ echo "argv[4] = $argv[4]\n"; }
	if($argc > 5){ echo "argv[5] = $argv[5]\n"; }
	if($argc > 6){ echo "argv[6] = $argv[6]\n"; }
	if($argc > 7){ echo "argv[7] = $argv[7]\n"; }
	if($argc > 8){ echo "argv[8] = $argv[8]\n"; }
	if($argc > 9){ echo "argv[9] = $argv[9]\n"; }

	return 0;
}







####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
function DKTEST(){ 
	#dk_debugFunc();

	$ret = dk_echo("testing dk_echo()", "abc", 123);
	echo "dk_echo():ret = $ret\n";
}

?>