<?php

##################################################################################
# dk_log()
#
function dk_log(){
	#dk_debugFunc(1 2)
	#echo("###### ".__FUNCTION__."(".implode(";", func_get_args()).") ######\n");
	include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/dk_color.php");

	if(!isset($dk_log_ENABLE)){ $dk_log_ENABLE = 1; }
	if($dk_log_ENABLE != 1){ return 0; }
	
	###### level order ######
	#	0 VERBOSE		dk_verbose
	#	1 DEBUG			dk_debug
	#	  DEFAULT		dk_default
	#	2 INFO			dk_info
	#	3 SUCCESS		dk_success
	#	4 TODO			dk_todo
	#	5 NOTICE		dk_notice
	#	6 FIXME			dk_fixme
	#	7 WARNING		dk_warning
	#	8 DEPRECATED	dk_deprecated
	#	9 ERROR			dk_error
	#  10 FATAL			dk_fatal

	###### option order ######
	#   ENABLE
	#   COLOR
	#   TAG
	#   TRACE
	#   LINE
	#   SOUND
	#   TIMEOUT
	#   PAUSE
	#   HALT

	### VERBOSE ###
	if(!isset($dk_log_VERBOSE_ENABLE))		{ $dk_log_VERBOSE_ENABLE = 1; }
	if(!isset($dk_log_VERBOSE_COLOR))		{ $dk_log_VERBOSE_COLOR=$GLOBALS['magenta']; }
	if(!isset($dk_log_VERBOSE_TAG))			{ $dk_log_VERBOSE_TAG="VERBOSE: "; }
	#if(!isset($dk_log_VERBOSE_TRACE))		{ $dk_log_VERBOSE_TRACE=0; }
	#if(!isset($dk_log_VERBOSE_LINE))		{ $dk_log_VERBOSE_LINE=0; }
	#if(!isset($dk_log_VERBOSE_TIMEOUT)) 	{ $dk_log_VERBOSE_TIMEOUT=0; }
	#if(!isset($dk_log_VERBOSE_PAUSE))		{ $dk_log_VERBOSE_PAUSE=0; }
	#if(!isset($dk_log_VERBOSE_HALT))		{ $dk_log_VERBOSE_HALT=0; }
	
	### DEBUG ###
	if(!isset($dk_log_DEBUG_ENABLE))		{ $dk_log_DEBUG_ENABLE=1; }
	if(!isset($dk_log_DEBUG_COLOR))			{ $dk_log_DEBUG_COLOR=$GLOBALS['lblue']; }
	if(!isset($dk_log_DEBUG_TAG))			{ $dk_log_DEBUG_TAG="DEBUG: "; }
	#if(!isset($dk_log_DEBUG_TRACE))		{ $dk_log_DEBUG_TRACE=0; }
	#if(!isset($dk_log_DEBUG_LINE))			{ $dk_log_DEBUG_LINE=0; }
	#if(!isset($dk_log_DEBUG_TIMEOUT))		{ $dk_log_DEBUG_TIMEOUT=0; }
	#if(!isset($dk_log_DEBUG_PAUSE))		{ $dk_log_DEBUG_PAUSE=0; }
	#if(!isset($dk_log_DEBUG_HALT))			{ $dk_log_DEBUG_HALT=0; }
	
	#### DEFAULT ###
	if(!isset($dk_log_DEFAULT_ENABLE))		{ $dk_log_DEFAULT_ENABLE=1; }
	if(!isset($dk_log_DEFAULT_COLOR))		{ $dk_log_DEFAULT_COLOR=$GLOBALS['white'];}
	#if(!isset($dk_log_DEFAULT_TAG))		{ $dk_log_DEFAULT_TAG=""; }
	#if(!isset($dk_log_DEFAULT_TRACE))		{ $dk_log_DEFAULT_TRACE=0; }
	#if(!isset($dk_log_DEFAULT_LINE))		{ $dk_log_DEFAULT_LINE=0; }
	#if(!isset($dk_log_DEFAULT_TIMEOUT))	{ $dk_log_DEFAULT_TIMEOUT=0; }
	#if(!isset($dk_log_DEFAULT_PAUSE))		{ $dk_log_DEFAULT_PAUSE=0; }
	#if(!isset($dk_log_DEFAULT_HALT))		{ $dk_log_DEFAULT_HALT=0; }
	
	#### INFO ###
	if(!isset($dk_log_INFO_ENABLE))			{ $dk_log_INFO_ENABLE=1; }
	if(!isset($dk_log_INFO_COLOR))			{ $dk_log_INFO_COLOR=$GLOBALS['white']; }
	if(!isset($dk_log_INFO_TAG))			{ $dk_log_INFO_TAG="INFO:  "; }
	#if(!isset($dk_log_INFO_TRACE))			{ $dk_log_INFO_TRACE=0; }
	#if(!isset($dk_log_INFO_LINE))			{ $dk_log_INFO_LINE=0; }
	#if(!isset($dk_log_INFO_TIMEOUT))		{ $dk_log_INFO_TIMEOUT=0; }
	#if(!isset($dk_log_INFO_PAUSE))			{ $dk_log_INFO_PAUSE=0; }
	#if(!isset($dk_log_INFO_HALT))			{ $dk_log_INFO_HALT=0; }
	
	#### SUCCESS ###
	if(!isset($dk_log_SUCCESS_ENABLE))		{ $dk_log_SUCCESS_ENABLE=1; }
	if(!isset($dk_log_SUCCESS_COLOR))		{ $dk_log_SUCCESS_COLOR=$GLOBALS['green']; }
	if(!isset($dk_log_SUCCESS_TAG))			{ $dk_log_SUCCESS_TAG="SUCCESS:  "; }
	#if(!isset($dk_log_SUCCESS_TRACE))		{ $dk_log_SUCCESS_TRACE=0; }
	#if(!isset($dk_log_SUCCESS_LINE))		{ $dk_log_SUCCESS_LINE=0; }
	#if(!isset($dk_log_SUCCESS_TIMEOUT))	{ $dk_log_SUCCESS_TIMEOUT=0; }
	#if(!isset($dk_log_SUCCESS_PAUSE))		{ $dk_log_SUCCESS_PAUSE=0; }
	#if(!isset($dk_log_SUCCESS_HALT))		{ $dk_log_SUCCESS_HALT=0; }
	
	#### TODO ###
	if(!isset($dk_log_TODO_ENABLE))			{ $dk_log_TODO_ENABLE=1; }
	if(!isset($dk_log_TODO_COLOR))			{ $dk_log_TODO_COLOR=$GLOBALS['blue']; }
	if(!isset($dk_log_TODO_TAG))			{ $dk_log_TODO_TAG="TODO:  "; }
	#if(!isset($dk_log_TODO_TRACE))			{ $dk_log_TODO_TRACE=0; }
	#if(!isset($dk_log_TODO_LINE))			{ $dk_log_TODO_LINE=0; }
	if(!isset($dk_log_TODO_TIMEOUT))		{ $dk_log_TODO_TIMEOUT=1; }
	#if(!isset($dk_log_TODO_PAUSE))			{ $dk_log_TODO_PAUSE=0; }
	#if(!isset($dk_log_TODO_HALT))			{ $dk_log_TODO_HALT=0; }
	
	#### NOTICE ###
	if(!isset($dk_log_NOTICE_ENABLE))		{ $dk_log_NOTICE_ENABLE=1; }
	if(!isset($dk_log_NOTICE_COLOR))		{ $dk_log_NOTICE_COLOR=$GLOBALS['lyellow']; }
	if(!isset($dk_log_NOTICE_TAG))			{ $dk_log_NOTICE_TAG="NOTICE:  "; }
	#if(!isset($dk_log_NOTICE_TRACE))		{ $dk_log_NOTICE_TRACE=0; }
	#if(!isset($dk_log_NOTICE_LINE))		{ $dk_log_NOTICE_LINE=0; }
	#if(!isset($dk_log_NOTICE_TIMEOUT))		{ $dk_log_NOTICE_TIMEOUT=0; }
	#if(!isset($dk_log_NOTICE_PAUSE))		{ $dk_log_NOTICE_PAUSE=0; }
	#if(!isset($dk_log_NOTICE_HALT))		{ $dk_log_NOTICE_HALT=0; }

	#### FIXME ###
	if(!isset($dk_log_FIXME_ENABLE))		{ $dk_log_FIXME_ENABLE=1; }
	if(!isset($dk_log_FIXME_COLOR))			{ $dk_log_FIXME_COLOR=$GLOBALS['lyellow']; }
	if(!isset($dk_log_FIXME_TAG))			{ $dk_log_FIXME_TAG="FIXME:  "; }
	#if(!isset($dk_log_FIXME_TRACE))		{ $dk_log_FIXME_TRACE=0; }
	#if(!isset($dk_log_FIXME_LINE))			{ $dk_log_FIXME_LINE=0; }
	if(!isset($dk_log_FIXME_TIMEOUT))		{ $dk_log_FIXME_TIMEOUT=3; }
	#if(!isset($dk_log_FIXME_PAUSE))		{ $dk_log_FIXME_PAUSE=0; }
	#if(!isset($dk_log_FIXME_HALT))			{ $dk_log_FIXME_HALT=0; }
	
	#### WARNING ###
	if(!isset($dk_log_WARNING_ENABLE))		{ $dk_log_WARNING_ENABLE=1; }
	if(!isset($dk_log_WARNING_COLOR))		{ $dk_log_WARNING_COLOR=$GLOBALS['yellow']; }
	if(!isset($dk_log_WARNING_TAG))			{ $dk_log_WARNING_TAG="WARNING:  "; }
	if(!isset($dk_log_WARNING_TRACE))		{ $dk_log_WARNING_TRACE=1; }
	#if(!isset($dk_log_WARNING_LINE))		{ $dk_log_WARNING_LINE=0; }
	#if(!isset($dk_log_WARNING_SOUND))		{ $dk_log_WARNING_SOUND=0; }
	#if(!isset($dk_log_WARNING_TIMEOUT))	{ $dk_log_WARNING_TIMEOUT=0; }
	#if(!isset($dk_log_WARNING_PAUSE))		{ $dk_log_WARNING_PAUSE=0; }
	#if(!isset($dk_log_WARNING_HALT))		{ $dk_log_WARNING_HALT=0; }
	
	#### DEPRECATED ###
	if(!isset($dk_log_DEPRECATED_ENABLE))	{ $dk_log_DEPRECATED_ENABLE=1; }
	if(!isset($dk_log_DEPRECATED_COLOR))	{ $dk_log_DEPRECATED_COLOR=$GLOBALS['dim'].$GLOBALS['yellow']; }
	if(!isset($dk_log_DEPRECATED_TAG))		{ $dk_log_DEPRECATED_TAG="DEPRECATED:  "; }
	if(!isset($dk_log_DEPRECATED_TRACE))	{ $dk_log_DEPRECATED_TRACE=1; }
	#if(!isset($dk_log_DEPRECATED_LINE))	{ $dk_log_DEPRECATED_LINE=0; }
	#if(!isset($dk_log_DEPRECATED_SOUND))	{ $dk_log_DEPRECATED_SOUND=0; }
	if(!isset($dk_log_DEPRECATED_TIMEOUT))	{ $dk_log_DEPRECATED_TIMEOUT=3; }
	#if(!isset($dk_log_DEPRECATED_PAUSE))	{ $dk_log_DEPRECATED_PAUSE=0; }
	#if(!isset($dk_log_DEPRECATED_HALT))	{ $dk_log_DEPRECATED_HALT=0; }
	
	#### ERROR ###
	if(!isset($dk_log_ERROR_ENABLE))		{ $dk_log_ERROR_ENABLE=1; }
	if(!isset($dk_log_ERROR_COLOR))			{ $dk_log_ERROR_COLOR=$GLOBALS['lred']; }
	if(!isset($dk_log_ERROR_TAG))			{ $dk_log_ERROR_TAG="ERROR:  "; }
	if(!isset($dk_log_ERROR_TRACE))			{ $dk_log_ERROR_TRACE=1; }
	#if(!isset($dk_log_ERROR_LINE))			{ $dk_log_ERROR_LINE=0; }
	#if(!isset($dk_log_ERROR_SOUND))		{ $dk_log_ERROR_SOUND=0; }
	if(!isset($dk_log_ERROR_TIMEOUT))		{ $dk_log_ERROR_TIMEOUT=3; }
	#if(!isset($dk_log_ERROR_PAUSE))		{ $dk_log_ERROR_PAUSE=0; }
	#if(!isset($dk_log_ERROR_HALT))			{ $dk_log_ERROR_HALT=0; }
	
	#### FATAL ###
	if(!isset($dk_log_FATAL_ENABLE))		{ $dk_log_FATAL_ENABLE=1; }
	if(!isset($dk_log_FATAL_COLOR))			{ $dk_log_FATAL_COLOR=$GLOBALS['red']; }
	if(!isset($dk_log_FATAL_TAG))			{ $dk_log_FATAL_TAG="FATAL:  "; }
	if(!isset($dk_log_FATAL_TRACE))			{ $dk_log_FATAL_TRACE=1; }
	#if(!isset($dk_log_FATAL_LINE))			{ $dk_log_FATAL_LINE=0; }
	#if(!isset($dk_log_FATAL_SOUND))		{ $dk_log_FATAL_SOUND=0; }
	if(!isset($dk_log_FATAL_TIMEOUT))		{ $dk_log_FATAL_TIMEOUT=9; }
	#if(!isset($dk_log_FATAL_PAUSE))		{ $dk_log_FATAL_PAUSE=0; }
	#if(!isset($dk_log_FATAL_HALT))			{ $dk_log_FATAL_HALT=0; }
	
	if(!isset($argv)){
		$argv = func_get_args();
	}
	if(isset($argv[1])){
		$_level_="$argv[0]";
		$_message_="$argv[1]";
	} else {
		$_level_="DEFAULT";
		$_message_="$argv[0]";
	}
	
	$ENABLE = "dk_log_".$_level_."_ENABLE";
	if($$ENABLE != 1){
		return 0;
	}
	$COLOR = "dk_log_".$_level_."_COLOR";
	
	###### ECHO MASSAGE ######
	echo($$COLOR.$_message_.$GLOBALS['clr']."\n");

	###### TRACE ######
	# TODO
	
	###### LINE ######
	# TODO
	
	###### SOUND ######
	# TODO
	
	###### PAUSE ######
	# TODO
	
	###### TIMEOUT ######
	# TODO
	
	###### HALT ######
	# TODO
	
	return 0;
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(!function_exists('DKTEST')){ function DKTEST() {
		#dk_debugFunc(0)

		dk_log("VERBOSE",		"test dk_log VERBOSE message");
		dk_log("DEBUG",			"test dk_log DEBUG message");
		dk_log(					"test dk_log message");
		dk_log("INFO",			"test dk_log INFO message");
		dk_log("SUCCESS",		"test dk_log SUCCESS message");
		dk_log("TODO",			"test dk_log TODO message");
		dk_log("NOTICE",		"test dk_log NOTICE message");
		dk_log("FIXME",			"test dk_log FIXME message");
		dk_log("WARNING",		"test dk_log WARNING message");
		dk_log("DEPRECATED",	"test dk_log DEPRECATED message");
		dk_log("ERROR",			"test dk_log ERROR message");
		dk_log("FATAL",			"test dk_log FATAL message");
}}


include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/DK.php");
?>