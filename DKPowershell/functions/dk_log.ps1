if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_log_ps1){ $dk_log_ps1 = 1; } else{ return; } #include guard

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

### DKLOG (GLOBAL DEFAULT) ###
if(!(${dk_log_DISABLE})) 			{ $global:dk_log_DISABLE = 0; }
if(!(${dk_log_COLOR}))  			{ $global:dk_log_COLOR = ${white}; }
if(!(${dk_log_TAG}))    			{ $global:dk_log_TAG = "PS: "; }
if(!(${dk_log_TRACE}))  			{ $global:dk_log_TRACE = 0; }
if(!(${dk_log_LINE}))   			{ $global:dk_log_LINE = 0; }
if(!(${dk_log_SOUND}))   			{ $global:dk_log_SOUND = 0; }
if(!(${dk_log_TIMEOUT}))   			{ $global:dk_log_TIMEOUT = 0; }
if(!(${dk_log_PAUSE}))  			{ $global:dk_log_PAUSE = 0; }
if(!(${dk_log_HALT}))   			{ $global:dk_log_HALT = 0; }

### VERBOSE ###
#if(!(${dk_log_VERBOSE_DISABLE})) 	{ $global:dk_log_VERBOSE_DISABLE = 0; }
if(!(${dk_log_VERBOSE_COLOR}))  	{ $global:dk_log_VERBOSE_COLOR = ${magenta}; }
if(!(${dk_log_VERBOSE_TAG}))    	{ $global:dk_log_VERBOSE_TAG = "VERBOSE: "; }
#if(!(${dk_log_VERBOSE_TRACE}))  	{ $global:dk_log_VERBOSE_TRACE = 0; }
#if(!(${dk_log_VERBOSE_LINE}))   	{ $global:dk_log_VERBOSE_LINE = 0; }
#if(!(${dk_log_VERBOSE_SOUND}))   	{ $global:dk_log_VERBOSE_SOUND = 0; }
#if(!(${dk_log_VERBOSE_TIMEOUT}))   { $global:dk_log_VERBOSE_TIMEOUT = 0; }
#if(!(${dk_log_VERBOSE_PAUSE}))  	{ $global:dk_log_VERBOSE_PAUSE = 0; }
#if(!(${dk_log_VERBOSE_HALT}))   	{ $global:dk_log_VERBOSE_HALT = 0; }

### DEBUG ###
#if(!(${dk_log_DEBUG_DISABLE}))   	{ $global:dk_log_DEBUG_DISABLE = 0; }
if(!(${dk_log_DEBUG_COLOR}))    	{ $global:dk_log_DEBUG_COLOR = ${blue}; }
if(!(${dk_log_DEBUG_TAG}))      	{ $global:dk_log_DEBUG_TAG = "DEBUG: "; }
#if(!(${dk_log_DEBUG_TRACE}))    	{ $global:dk_log_DEBUG_TRACE = 0; }
#if(!(${dk_log_DEBUG_LINE}))     	{ $global:dk_log_DEBUG_LINE = 0; }
#if(!(${dk_log_DEBUG_SOUND}))     	{ $global:dk_log_DEBUG_SOUND = 0; }
#if(!(${dk_log_DEBUG_TIMEOUT}))     { $global:dk_log_DEBUG_TIMEOUT = 0; }
#if(!(${dk_log_DEBUG_PAUSE}))    	{ $global:dk_log_DEBUG_PAUSE = 0; }
#if(!(${dk_log_DEBUG_HALT}))     	{ $global:dk_log_DEBUG_HALT = 0; }

### DEFAULT ###
#if(!(${dk_log_DEFAULT_DISABLE})) 	{ $global:dk_log_DEFAULT_DISABLE = 0; }
#if(!(${dk_log_DEFAULT_COLOR}))  	{ $global:dk_log_DEFAULT_COLOR = ${white}; }
#if(!(${dk_log_DEFAULT_TAG}))   	{ $global:dk_log_DEFAULT_TAG = DEFAULT: "; }
#if(!(${dk_log_DEFAULT_TRACE}))  	{ $global:dk_log_DEFAULT_TRACE = 0; }
#if(!(${dk_log_DEFAULT_LINE}))   	{ $global:dk_log_DEFAULT_LINE = 0; }
#if(!(${dk_log_DEFAULT_SOUND}))   	{ $global:dk_log_DEFAULT_SOUND = 0; }
#if(!(${dk_log_DEFAULT_TIMEOUT}))   { $global:dk_log_DEFAULT_TIMEOUT = 0; }
#if(!(${dk_log_DEFAULT_PAUSE}))  	{ $global:dk_log_DEFAULT_PAUSE = 0; }
#if(!(${dk_log_DEFAULT_HALT}))   	{ $global:dk_log_DEFAULT_HALT = 0; }

### INFO ###
#if(!(${dk_log_INFO_DISABLE}))    	{ $global:dk_log_INFO_DISABLE = 0; }
if(!(${dk_log_INFO_COLOR}))     	{ $global:dk_log_INFO_COLOR = ${white}; }
if(!(${dk_log_INFO_TAG}))       	{ $global:dk_log_INFO_TAG = "INFO: "; }
#if(!(${dk_log_INFO_TRACE}))     	{ $global:dk_log_INFO_TRACE = 0; }
#if(!(${dk_log_INFO_LINE}))      	{ $global:dk_log_INFO_LINE = 0; }
#if(!(${dk_log_INFO_SOUND}))      	{ $global:dk_log_INFO_SOUND = 0; }
#if(!(${dk_log_INFO_TIMEOUT}))      { $global:dk_log_INFO_TIMEOUT = 0; }
#if(!(${dk_log_INFO_PAUSE}))     	{ $global:dk_log_INFO_PAUSE = 0; }
#if(!(${dk_log_INFO_HALT}))      	{ $global:dk_log_INFO_HALT = 0; }

### SUCCESS ###
#if(!(${dk_log_SUCCESS_DISABLE}))  	{ $global:dk_log_SUCCESS_DISABLE = 0; }
if(!(${dk_log_SUCCESS_COLOR}))   	{ $global:dk_log_SUCCESS_COLOR = ${green}; }
if(!(${dk_log_SUCCESS_TAG}))     	{ $global:dk_log_SUCCESS_TAG = "SUCCESS: "; }
#if(!(${dk_log_SUCCESS_TRACE}))   	{ $global:dk_log_SUCCESS_TRACE = 0; }
#if(!(${dk_log_SUCCESS_LINE}))    	{ $global:dk_log_SUCCESS_LINE = 0; }
#if(!(${dk_log_SUCCESS_SOUND}))    	{ $global:dk_log_SUCCESS_SOUND = 0; }
#if(!(${dk_log_SUCCESS_TIMEOUT}))   { $global:dk_log_SUCCESS_TIMEOUT = 0; }
#if(!(${dk_log_SUCCESS_PAUSE}))   	{ $global:dk_log_SUCCESS_PAUSE = 0; }
#if(!(${dk_log_SUCCESS_HALT}))    	{ $global:dk_log_SUCCESS_HALT = 0; }

### TODO ###
#if(!(${dk_log_TODO_DISABLE}))		{ $global:dk_log_TODO_DISABLE = 0; }
if(!(${dk_log_TODO_COLOR}))			{ $global:dk_log_TODO_COLOR = ${lblue}; }
if(!(${dk_log_TODO_TAG}))			{ $global:dk_log_TODO_TAG = "TODO: "; }
#if(!(${dk_log_TODO_TRACE}))		{ $global:dk_log_TODO_TRACE = 0; }
#if(!(${dk_log_TODO_LINE}))			{ $global:dk_log_TODO_LINE = 0; }
#if(!(${dk_log_TODO_SOUND}))		{ $global:dk_log_TODO_SOUND = 0; }
#if(!(${dk_log_TODO_TIMEOUT}))		{ $global:dk_log_TODO_TIMEOUT = 0; }
#if(!(${dk_log_TODO_PAUSE}))		{ $global:dk_log_TODO_PAUSE = 1; }
#if(!(${dk_log_TODO_HALT}))			{ $global:dk_log_TODO_HALT = 0; }

### NOTICE ###
#if(!(${dk_log_NOTICE_DISABLE}))  	{ $global:dk_log_NOTICE_DISABLE = 0; }
if(!(${dk_log_NOTICE_COLOR}))   	{ $global:dk_log_NOTICE_COLOR = ${lyellow}; }
if(!(${dk_log_NOTICE_TAG}))     	{ $global:dk_log_NOTICE_TAG = "NOTICE: "; }
#if(!(${dk_log_NOTICE_TRACE}))   	{ $global:dk_log_NOTICE_TRACE = 0; }
#if(!(${dk_log_NOTICE_LINE}))    	{ $global:dk_log_NOTICE_LINE = 0; }
#if(!(${dk_log_NOTICE_SOUND}))    	{ $global:dk_log_NOTICE_SOUND = 0; }
#if(!(${dk_log_NOTICE_TIMEOUT}))    { $global:dk_log_NOTICE_TIMEOUT = 0; }
#if(!(${dk_log_NOTICE_PAUSE}))   	{ $global:dk_log_NOTICE_PAUSE = 0; }
#if(!(${dk_log_NOTICE_HALT}))    	{ $global:dk_log_NOTICE_HALT = 0; }

### FIXME ###
#if(!(${dk_log_FIXME_DISABLE}))   	{ $global:dk_log_FIXME_DISABLE = 0; }
if(!(${dk_log_FIXME_COLOR}))    	{ $global:dk_log_FIXME_COLOR = ${lred}; }
if(!(${dk_log_FIXME_TAG}))      	{ $global:dk_log_FIXME_TAG = "FIXME: "; }
#if(!(${dk_log_FIXME_TRACE}))    	{ $global:dk_log_FIXME_TRACE = 0; }
#if(!(${dk_log_FIXME_LINE}))     	{ $global:dk_log_FIXME_LINE = 0; }
#if(!(${dk_log_FIXME_SOUND}))     	{ $global:dk_log_FIXME_SOUND = 0; }
#if(!(${dk_log_FIXME_TIMEOUT}))     { $global:dk_log_FIXME_TIMEOUT = 0; }
#if(!(${dk_log_FIXME_PAUSE}))    	{ $global:dk_log_FIXME_PAUSE = 1; }
#if(!(${dk_log_FIXME_HALT}))     	{ $global:dk_log_FIXME_HALT = 0; }

### WARNING ###
#if(!(${dk_log_WARNING_DISABLE})) 	{ $global:dk_log_WARNING_DISABLE = 0; }
if(!(${dk_log_WARNING_COLOR}))  	{ $global:dk_log_WARNING_COLOR = ${yellow}; }
if(!(${dk_log_WARNING_TAG}))    	{ $global:dk_log_WARNING_TAG = "WARNING: "; }
#if(!(${dk_log_WARNING_TRACE}))  	{ $global:dk_log_WARNING_TRACE = 0; }
#if(!(${dk_log_WARNING_LINE}))  	{ $global:dk_log_WARNING_LINE = 0; }
#if(!(${dk_log_WARNING_SOUND}))  	{ $global:dk_log_WARNING_SOUND = 0; }
#if(!(${dk_log_WARNING_TIMEOUT}))  	{ $global:dk_log_WARNING_TIMEOUT = 0; }
#if(!(${dk_log_WARNING_PAUSE}))  	{ $global:dk_log_WARNING_PAUSE = 0; }
#if(!(${dk_log_WARNING_HALT}))   	{ $global:dk_log_WARNING_HALT = 0; }

### DEPRECATED ###
#if(!(${dk_log_DEPRECATED_DISABLE})){ $global:dk_log_DEPRECATED_DISABLE = 0; }
if(!(${dk_log_DEPRECATED_COLOR}))   { $global:dk_log_DEPRECATED_COLOR = ${lred}; }
if(!(${dk_log_DEPRECATED_TAG}))     { $global:dk_log_DEPRECATED_TAG = "DEPRECATED: "; }
#if(!(${dk_log_DEPRECATED_TRACE}))  { $global:dk_log_DEPRECATED_TRACE = 0; }
#if(!(${dk_log_DEPRECATED_LINE}))   { $global:dk_log_DEPRECATED_LINE = 0; }
#if(!(${dk_log_DEPRECATED_SOUND}))  { $global:dk_log_DEPRECATED_SOUND = 0; }
#if(!(${dk_log_DEPRECATED_TIMEOUT})){ $global:dk_log_DEPRECATED_TIMEOUT = 0; }
#if(!(${dk_log_DEPRECATED_PAUSE}))   { $global:dk_log_DEPRECATED_PAUSE = 1; }
#if(!(${dk_log_DEPRECATED_HALT}))   { $global:dk_log_DEPRECATED_HALT = 0; }

### ERROR ###
#if(!(${dk_log_ERROR_DISABLE}))   	{ $global:dk_log_ERROR_DISABLE = 0; }
if(!(${dk_log_ERROR_COLOR}))    	{ $global:dk_log_ERROR_COLOR = ${red}; }
if(!(${dk_log_ERROR_TAG}))      	{ $global:dk_log_ERROR_TAG = "ERROR: "; }
#if(!(${dk_log_ERROR_TRACE}))    	{ $global:dk_log_ERROR_TRACE = 0; }
#if(!(${dk_log_ERROR_LINE}))     	{ $global:dk_log_ERROR_LINE = 0; }
#if(!(${dk_log_ERROR_SOUND}))     	{ $global:dk_log_ERROR_SOUND = 0; }
#if(!(${dk_log_ERROR_TIMEOUT}))     { $global:dk_log_ERROR_TIMEOUT = 0; }
#if(!(${dk_log_ERROR_PAUSE}))    	{ $global:dk_log_ERROR_PAUSE = 1; }
#if(!(${dk_log_ERROR_HALT}))     	{ $global:dk_log_ERROR_HALT = 0; }

### FATAL ###
#if(!(${dk_log_FATAL_DISABLE}))   	{ $global:dk_log_FATAL_DISABLE = 0; }
if(!(${dk_log_FATAL_COLOR}))    	{ $global:dk_log_FATAL_COLOR = ${red}; }
if(!(${dk_log_FATAL_TAG}))      	{ $global:dk_log_FATAL_TAG = "FATAL: "; }
#if(!(${dk_log_FATAL_TRACE}))    	{ $global:dk_log_FATAL_TRACE = 0; }
#if(!(${dk_log_FATAL_LINE}))     	{ $global:dk_log_FATAL_LINE = 0; }
#if(!(${dk_log_FATAL_SOUND}))     	{ $global:dk_log_FATAL_SOUND = 0; }
#if(!(${dk_log_FATAL_TIMEOUT}))     { $global:dk_log_FATAL_TIMEOUT = 0; }
#if(!(${dk_log_FATAL_PAUSE}))    	{ $global:dk_log_FATAL_PAUSE = 0; }
if(!(${dk_log_FATAL_HALT}))     	{ $global:dk_log_FATAL_HALT = 1; }




################################################################################
# dk_log(message)
# dk_log(level, message)
#
#    Print a message to the console
#
#    @level		- The log level to use
#    @message	- The message to print
#
function Global:dk_log() {
	dk_debugFunc 0 2;

	if(${dk_log_DISABLE} -eq 1){ return; }
	
	if(!($args[1])){
		${_message_} = ($args[0]);
	} else {
		${_level_} = ($args[0]);
		${_message_} = ($args[1]);
	}
	
	if(${_level_}){
		${_level_} += "_";
	}
	#if(!(Test-Path variable:echo_fileline)){ $global:echo_fileline = "$(__FILE__ 1):$(__LINE__ 1)   " }

	if(Get-Variable "dk_log_${_level_}DISABLE" 	-ErrorAction SilentlyContinue)	{ ${dk_log_DISABLE} = Get-Variable "dk_log_${_level_}DISABLE"	-valueOnly; }
	if(${dk_log_DISABLE} -eq 1){ return; }
	if(Get-Variable "dk_log_${_level_}COLOR" 	-ErrorAction SilentlyContinue)	{ ${dk_log_COLOR} 	= Get-Variable "dk_log_${_level_}COLOR"		-valueOnly; }
	if(Get-Variable "dk_log_${_level_}TAG" 		-ErrorAction SilentlyContinue)	{ ${dk_log_TAG} 	= Get-Variable "dk_log_${_level_}TAG"		-valueOnly; }
	if(Get-Variable "dk_log_${_level_}TRACE" 	-ErrorAction SilentlyContinue)	{ ${dk_log_TRACE} 	= Get-Variable "dk_log_${_level_}TRACE"		-valueOnly; }
	if(Get-Variable "dk_log_${_level_}LINE" 	-ErrorAction SilentlyContinue)	{ ${dk_log_LINE} 	= Get-Variable "dk_log_${_level_}LINE"		-valueOnly; }
	if(Get-Variable "dk_log_${_level_}SOUND" 	-ErrorAction SilentlyContinue)	{ ${dk_log_SOUND} 	= Get-Variable "dk_log_${_level_}SOUND"		-valueOnly; }
	if(Get-Variable "dk_log_${_level_}TIMEOUT" 	-ErrorAction SilentlyContinue)	{ ${dk_log_TIMEOUT} = Get-Variable "dk_log_${_level_}TIMEOUT"	-valueOnly; }
	if(Get-Variable "dk_log_${_level_}PAUSE" 	-ErrorAction SilentlyContinue)	{ ${dk_log_PAUSE} 	= Get-Variable "dk_log_${_level_}PAUSE"		-valueOnly; }
	if(Get-Variable "dk_log_${_level_}HALT"		-ErrorAction SilentlyContinue)	{ ${dk_log_HALT} 	= Get-Variable "dk_log_${_level_}HALT"		-valueOnly; }

	
	###### ECHO MESSAGE ######
	dk_call dk_echo "${dk_log_COLOR}${dk_log_TAG}${_message_}${clr}"
	
	###### TRACE ######
	if(${dk_log_TRACE} -eq 1)	{ dk_call dk_echo "${dk_log_COLOR}*** TRACE_ON_${_level_} ***${clr}"; dk_call dk_stacktrace; }
	
	###### LINE ######
	if(${dk_log_LINE} -eq 1)	{  dk_call dk_echo "${dk_log_COLOR}*** LINE_ON_${_level_} ***${clr}"; dk_call dk_showFileLine "${POWERSHELL_SOURCE[1]}" "${POWERSHELL_LINENO[1-1]}"; }
	
	###### SOUND ######
	if(${dk_log_PAUSE} -eq 1)	{ dk_call dk_echo "${dk_log_COLOR}*** SOUND_ON_${_level_} ***${clr}"; } #dk_call dk_sound; }
	
	###### TIMEOUT ######
	if(${dk_log_TIMEOUT} -gt 1)	{ dk_call dk_echo "${dk_log_COLOR}*** TIMEOUT_ON_${_level_} ***${clr}"; } #dk_call dk_timeout ${dk_log_TIMEOUT}; }
	
	###### PAUSE ######
	if(${dk_log_PAUSE} -eq 1)	{ dk_call dk_echo "${dk_log_COLOR}*** PAUSE_ON_${_level_} ***${clr}"; dk_call dk_pause; }
	
	###### HALT ######
	if(${dk_log_HALT} -eq 1)	{ dk_call dk_echo "${dk_log_COLOR}*** HALT_ON_${_level_} ***${clr}"; dk_call dk_exit; }
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_call dk_debugFunc 0;
	
	dk_call dk_log VERBOSE		"test dk_log VERBOSE message";
	dk_call dk_log DEBUG		"test dk_log DEBUG message";
	dk_call dk_log				"test dk_log message";
	dk_call dk_log INFO			"test dk_log INFO message";
	dk_call dk_log SUCCESS		"test dk_log SUCCESS message";
	dk_call dk_log TODO			"test dk_log TODO message";
	dk_call dk_log NOTICE		"test dk_log NOTICE message";
	dk_call dk_log FIXME		"test dk_log FIXME message";
	dk_call dk_log WARNING		"test dk_log WARNING message";
	dk_call dk_log DEPRECATED	"test dk_log DEPRECATED message";
	dk_call dk_log ERROR		"test dk_log ERROR message";
	dk_call dk_log FATAL		"test dk_log FATAL message";
}
