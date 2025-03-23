<?php
header('Access-Control-Allow-Origin: *');

##################################################################################
# DK()
#
#	PHP: https://www.php.net/manual/en/function.realpath.php
#

function DK(){
	#dk_debugFunc();
	echo "###### ".__FUNCTION__."(".implode(";", func_get_args()).") ######\n";

	$COMSPEC = getenv('COMSPEC');
	if(isset($COMSPEC)){
		$DKSHELL_PATH = getenv('COMSPEC');
	}
	$HOME = getenv('HOME');
	echo "HOME = $HOME\n";
	if(isset($HOME)){
		echo "HOME = $HOME\n";
#		$DKSHELL_PATH = $HOME;
	}
	echo "DKSHELL_PATH = $DKSHELL_PATH\n";
	
	
	$USERPROFILE = getenv('USERPROFILE');
	echo "USERPROFILE = $USERPROFILE\n";


	### command ###
	$output=null;
	$retval=null;
	exec('whoami', $output, $retval);
	$WHOAMI = $output[0]; 
	echo "Returned with status $retval and output:\n";
	echo "WHOAMI = $WHOAMI\n";

}
DK();




####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
if(!function_exists('DKTEST')){
	function DKTEST(){ 
		#dk_debugFunc();

		DK();
	}
}
?>