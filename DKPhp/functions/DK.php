<?php
header('Access-Control-Allow-Origin: *');

##################################################################################
# dk_realpath(path) -> rtn_var
#
#	PHP: https://www.php.net/manual/en/function.realpath.php
#

function DK(){
	echo "DK()\n";

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

?>