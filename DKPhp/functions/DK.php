<?php
//header('Access-Control-Allow-Origin: *');


##################################################################################
# DK()
#
#	PHP: https://www.php.net/manual/en/function.realpath.php
#


function DK(){
	#dk_debugFunc();
	#echo "###### ".__FUNCTION__."(".implode(";", func_get_args()).") ######\n";
	
	if(!isset($argv)){
		$argv = func_get_args();
	}
	
	$DKSCRIPT_PATH = $argv[0];
	$DKSCRIPT_FILE = basename("${DKSCRIPT_PATH}");
	$DKSCRIPT_NAME = pathinfo($DKSCRIPT_FILE, PATHINFO_FILENAME);
	$DKSCRIPT_EXT =	".".pathinfo($DKSCRIPT_FILE, PATHINFO_EXTENSION);
	#echo("DKSCRIPT_PATH = ${DKSCRIPT_PATH}\n");
	#echo("DKSCRIPT_FILE = ${DKSCRIPT_FILE}\n");
	#echo("DKSCRIPT_NAME = ${DKSCRIPT_NAME}\n");
	#echo("DKSCRIPT_EXT = ${DKSCRIPT_EXT}\n");

	include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/dk_color.php");
	include_once("{$DKSCRIPT_PATH}");

	#echo "DKSCRIPT_PATH = ".$GLOBALS['DKSCRIPT_PATH']."\n";
	$argv = func_get_args();
	
	$COMSPEC = getenv('COMSPEC');
	if(isset($COMSPEC)){
		$DKSHELL_PATH = getenv('COMSPEC');
	}
	$HOME = getenv('HOME');
	#echo "HOME = $HOME\n";
	if(isset($HOME)){
		#echo "HOME = $HOME\n";
#		$DKSHELL_PATH = $HOME;
	}
	echo "DKSHELL_PATH = $DKSHELL_PATH\n";
	
	$USERPROFILE = getenv('USERPROFILE');
	#echo "USERPROFILE = $USERPROFILE\n";
	
	### command ###
	$output=null;
	$retval=null;
	exec('whoami', $output, $retval);
	$WHOAMI = $output[0]; 
	echo "Returned with status $retval and output:\n";
	echo "WHOAMI = $WHOAMI\n";
	
	
	###### DKTEST MODE ######
    //[ "${DKSCRIPT_EXT}" = ".sh" ] || return 0
	//dk_fileContains "${DKSCRIPT_PATH}" "DKTEST()" || return 0
	echo("\n".$GLOBALS['bg_magenta'].$GLOBALS['white']."###### DKTEST MODE ###### ${DKSCRIPT_FILE} ###### DKTEST MODE ######".$GLOBALS['clr']."\n\n");
    #dk_echo "${bg_RGB}20;20;20m"
    //dk_source "${DKSCRIPT_PATH}"
    #dk_call dk_echo "$(type DKTEST | sed '1,1d')"             # print DKTEST(){ ... } code
    #dk_call dk_echo "${clr}"
	//if(function_exists('DKTEST')){
		DKTEST();
	//}
    echo("\n".$GLOBALS['bg_magenta'].$GLOBALS['white']."########################## END TEST ################################".$GLOBALS['clr']."\n\n");
    //dk_exit 0
}




/*
if($GLOBALS['DKSCRIPT_PATH'] == __FILE__){
	echo("loading DK.php:DKTEST()\n");
	function DKTEST(){ 
		#dk_debugFunc();
		DK();
	}
}
*/

DK("$argv[0]");


?>