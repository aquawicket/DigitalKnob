<?php
//header('Access-Control-Allow-Origin: *');
echo "DK.php\n";

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
	
	echo "argv[0] = $argv[0]\n";
	
	global $DKSCRIPT_PATH; $DKSCRIPT_PATH = getenv('DKSCRIPT_PATH');
	if(!isset($DKSCRIPT_PATH)){ $DKSCRIPT_PATH = $argv[0]; }
	echo("DKSCRIPT_PATH = {$DKSCRIPT_PATH}\n");
	
	global $DKSCRIPT_DIR; $DKSCRIPT_DIR = getenv('DKSCRIPT_DIR');
	if(!isset($DKSCRIPT_DIR)){ $DKSCRIPT_DIR = dirname("{$DKSCRIPT_PATH}"); }
	echo("DKSCRIPT_DIR = {$DKSCRIPT_DIR}\n");
	
	global $DKSCRIPT_FILE; $DKSCRIPT_FILE = getenv('DKSCRIPT_FILE');
	if(!isset($DKSCRIPT_FILE)){ $DKSCRIPT_FILE = basename("{$DKSCRIPT_PATH}"); }
	echo("DKSCRIPT_FILE = {$DKSCRIPT_FILE}\n");
	
	global $DKSCRIPT_NAME; $DKSCRIPT_NAME = getenv('DKSCRIPT_NAME');
	if(!isset($DKSCRIPT_NAME)){ $DKSCRIPT_NAME = pathinfo($DKSCRIPT_FILE, PATHINFO_FILENAME); }
	echo("DKSCRIPT_NAME = {$DKSCRIPT_NAME}\n");
	
	global $DKSCRIPT_EXT; $DKSCRIPT_EXT = getenv('DKSCRIPT_EXT');
	if(!isset($DKSCRIPT_EXT)){ $DKSCRIPT_EXT = ".".pathinfo($DKSCRIPT_FILE, PATHINFO_EXTENSION); }
	echo("DKSCRIPT_EXT = {$DKSCRIPT_EXT}\n");

	include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/DigitalKnob/Development/DKPhp/functions/dk_color.php");
	if("$DKSCRIPT_EXT" == ".php"){
		include_once("{$DKSCRIPT_PATH}");
	}

	#echo "DKSCRIPT_PATH = ".$GLOBALS['DKSCRIPT_PATH']."\n";
	
	$COMSPEC = getenv('COMSPEC');
	if(isset($COMSPEC)){
		$DKSHELL_PATH = getenv('COMSPEC');
	}
	$HOME = getenv('HOME');
	echo "HOME = $HOME\n";
#	if(isset($HOME)){
#		#echo "HOME = $HOME\n";
#		$DKSHELL_PATH = $HOME;
#	}
	echo "DKSHELL_PATH = $DKSHELL_PATH\n";
	
	$USERPROFILE = getenv('USERPROFILE');
	echo "USERPROFILE = $USERPROFILE\n";
	
	###### DKTEST MODE ######
	if("$DKSCRIPT_EXT" == ".php"){
		echo "###### DKTEST MODE ######\n";
		//dk_fileContains "{$DKSCRIPT_PATH}" "DKTEST()" || return 0;
		echo("\n".$GLOBALS['bg_magenta'].$GLOBALS['white']."###### DKTEST MODE ###### {$DKSCRIPT_FILE} ###### DKTEST MODE ######".$GLOBALS['clr']."\n\n");
			DKTEST();
		echo("\n".$GLOBALS['bg_magenta'].$GLOBALS['white']."########################## END TEST ################################".$GLOBALS['clr']."\n\n");
	} 
	else {
		echo "###### RUN MODE ######\n";
		if(!isset($DKSCRIPT_FUNCTION)){ $DKSCRIPT_FUNCTION = basename($argv[0]); }
		include_once($argv[0]);
		$DKSCRIPT_FUNCTION();
	}
}


DK("$argv[0]");
?>