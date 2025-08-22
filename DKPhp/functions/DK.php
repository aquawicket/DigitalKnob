<?php
//header('Access-Control-Allow-Origin: *');
echo "DK.php\n";
global $CMDLINE_PATH; $CMDLINE_PATH = $argv[0];                                        echo("CMDLINE_PATH = {$CMDLINE_PATH}\n");
global $CMDLINE_DIR;  $CMDLINE_DIR  = dirname("{$CMDLINE_PATH}");                      echo("CMDLINE_DIR  = {$CMDLINE_DIR}\n");
global $CMDLINE_FILE; $CMDLINE_FILE = basename("{$CMDLINE_PATH}");                     echo("CMDLINE_FILE = {$CMDLINE_FILE}\n");
global $CMDLINE_NAME; $CMDLINE_NAME = pathinfo($CMDLINE_FILE, PATHINFO_FILENAME);      echo("CMDLINE_NAME = {$CMDLINE_NAME}\n");
global $CMDLINE_EXT;  $CMDLINE_EXT  = ".".pathinfo($CMDLINE_FILE, PATHINFO_EXTENSION); echo("CMDLINE_EXT  = {$CMDLINE_EXT}\n");
global $CMDLINE_ARGS; $CMDLINE_ARGS = implode(";", array_slice($argv, 1));             echo("CMDLINE_ARGS = {$CMDLINE_ARGS}\n");

##################################################################################
# DK()
#
#	PHP: https://www.php.net/manual/en/function.realpath.php
#
function DK(){
	#dk_debugFunc(1, 99);
	#echo "###### ".__FUNCTION__."(".implode(";", func_get_args()).") ######\n";
	if(empty($argv))			{ $argv = func_get_args(); }
	
	global $DKSCRIPT_PATH; 
	if(empty($DKSCRIPT_PATH))	{ $DKSCRIPT_PATH = getenv('DKSCRIPT_PATH'); }
	if(empty($DKSCRIPT_PATH))	{ $DKSCRIPT_PATH = $argv[0]; }
	echo("DKSCRIPT_PATH = {$DKSCRIPT_PATH}\n");
	
	global $DKSCRIPT_DIR;
	if(empty($DKSCRIPT_DIR))	{ $DKSCRIPT_DIR = getenv('DKSCRIPT_DIR'); }
	if(empty($DKSCRIPT_DIR))	{ $DKSCRIPT_DIR = dirname("{$DKSCRIPT_PATH}"); }
	echo("DKSCRIPT_DIR = {$DKSCRIPT_DIR}\n");
	
	global $DKSCRIPT_FILE; 
	if(empty($DKSCRIPT_FILE))	{ $DKSCRIPT_FILE = getenv('DKSCRIPT_FILE'); }
	if(empty($DKSCRIPT_FILE))	{ $DKSCRIPT_FILE = basename("{$DKSCRIPT_PATH}"); }
	echo("DKSCRIPT_FILE = {$DKSCRIPT_FILE}\n");
	
	global $DKSCRIPT_NAME; 
	if(empty($DKSCRIPT_NAME))	{ $DKSCRIPT_NAME = getenv('DKSCRIPT_NAME'); }
	if(empty($DKSCRIPT_NAME))	{ $DKSCRIPT_NAME = pathinfo($DKSCRIPT_FILE, PATHINFO_FILENAME); }
	echo("DKSCRIPT_NAME = {$DKSCRIPT_NAME}\n");
	
	global $DKSCRIPT_EXT; 
	if(empty($DKSCRIPT_EXT))	{ $DKSCRIPT_EXT = getenv('DKSCRIPT_EXT'); }
	if(empty($DKSCRIPT_EXT))	{ $DKSCRIPT_EXT = ".".pathinfo($DKSCRIPT_FILE, PATHINFO_EXTENSION); }
	echo("DKSCRIPT_EXT = {$DKSCRIPT_EXT}\n");

	global $DKSCRIPT_ARGS; 
	if(empty($DKSCRIPT_ARGS))	{ $DKSCRIPT_ARGS = getenv('DKSCRIPT_ARGS'); }
	if(empty($DKSCRIPT_ARGS))	{ $DKSCRIPT_ARGS = implode(";", array_slice($argv, 1)); }
	echo("DKSCRIPT_ARGS = {$DKSCRIPT_ARGS}\n");
	
	global $COMSPEC;
	if(empty($COMSPEC))			{ $COMSPEC = getenv('COMSPEC'); }
	echo("COMSPEC = {$COMSPEC}\n");
	
	global $DKSHELL_PATH;
	if(empty($DKSHELL_PATH))	{ $DKSHELL_PATH = $COMSPEC; }
	echo("DKSHELL_PATH = {$DKSHELL_PATH}\n");
	
	global $HOME;
	if(empty($HOME))			{ $HOME = getenv('HOME'); }
	echo("HOME = {$HOME}\n");
	
	global $USERPROFILE;
	if(empty($USERPROFILE))		{ $USERPROFILE = getenv('USERPROFILE'); }
	echo("USERPROFILE = {$USERPROFILE}\n");

	
	include_once(str_replace("\\", "/", $USERPROFILE)."/DigitalKnob/Development/DKPhp/functions/dk_source.php");
	dk_source("dk_color");
	
	
	if("$DKSCRIPT_EXT" == ".php"){
		
		###### DKTEST MODE ######
		dk_source("dk_fileContains");
		if(dk_fileContains("{$DKSCRIPT_PATH}", "function DKTEST()") && empty($_SERVER['DKTEST'])){
			echo("\n".$GLOBALS['bg_magenta'].$GLOBALS['white']."###### DKTEST MODE ###### {$DKSCRIPT_FILE} ###### DKTEST MODE ######".$GLOBALS['clr']."\n\n");
				DKTEST();
			echo("\n".$GLOBALS['bg_magenta'].$GLOBALS['white']."########################## END TEST ################################".$GLOBALS['clr']."\n\n");
		}
		
		######## RUN MODE #######
		else {
			echo("\n".$GLOBALS['bg_blue'].$GLOBALS['white']."######################### {$DKSCRIPT_FILE} #########################".$GLOBALS['clr']."\n\n");
			$DKSCRIPT_NAME($DKSCRIPT_ARGS);
		}
	} 
	######## RUN MODE #######
	else {
		# $GLOBAL variables accessed using the $GLOBALS['var'] method
		echo("CMDLINE_PATH = ".$GLOBALS['CMDLINE_PATH']."\n");
		echo("CMDLINE_DIR = ".$GLOBALS['CMDLINE_DIR']."\n");
		echo("CMDLINE_FILE = ".$GLOBALS['CMDLINE_FILE']."\n");
		echo("CMDLINE_NAME = ".$GLOBALS['CMDLINE_NAME']."\n");
		echo("CMDLINE_EXT = ".$GLOBALS['CMDLINE_EXT']."\n");
		echo("CMDLINE_ARGS = ".$GLOBALS['CMDLINE_ARGS']."\n");
		include_once($GLOBALS['CMDLINE_PATH']);
		$GLOBALS['CMDLINE_NAME']($GLOBALS['CMDLINE_ARGS']);
		
		# $GLOBAL copied into the local scope
		#extract($GLOBALS);
		#echo("CMDLINE_PATH = {$CMDLINE_PATH}\n");
		#echo("CMDLINE_DIR  = {$CMDLINE_DIR}\n");
		#echo("CMDLINE_FILE = {$CMDLINE_FILE}\n");
		#echo("CMDLINE_NAME = {$CMDLINE_NAME}\n");
		#echo("CMDLINE_EXT  = {$CMDLINE_EXT}\n");
		#echo("CMDLINE_ARGS = {$CMDLINE_ARGS}\n");
		#include_once($CMDLINE_PATH);
		#$CMDLINE_NAME($CMDLINE_ARGS);
	}
}


DK($CMDLINE_PATH, $CMDLINE_ARGS);
?>