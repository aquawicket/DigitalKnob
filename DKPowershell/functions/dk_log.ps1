if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_log){ $dk_log = 1 } else{ return } #include guard

if(!(${ENABLE_dk_log}))  { $global:ENABLE_dk_log = 1 }

# DEFAULT
if(!(${DEFAULT_ENABLE})) { $global:DEFAULT_ENABLE = 1 }
if(!(${DEFAULT_COLOR}))  { $global:DEFAULT_COLOR = ${white} }
#if(!(${DEFAULT_TAG}))   { $global:DEFAULT_TAG = bat>: " }
if(!(${DEFAULT_PAUSE}))  { $global:DEFAULT_PAUSE = 0 }
if(!(${DEFAULT_TRACE}))  { $global:DEFAULT_TRACE = 0 }
if(!(${DEFAULT_LINE}))   { $global:DEFAULT_LINE = 0 }
if(!(${DEFAULT_HALT}))   { $global:DEFAULT_HALT = 0 }

# VERBOSE
if(!(${VERBOSE_ENABLE})) { $global:VERBOSE_ENABLE = 1 }
if(!(${VERBOSE_COLOR}))  { $global:VERBOSE_COLOR = ${magenta} }
if(!(${VERBOSE_TAG}))    { $global:VERBOSE_TAG = "VERBOSE: " }
if(!(${VERBOSE_PAUSE}))  { $global:VERBOSE_PAUSE = 0 }
if(!(${VERBOSE_TRACE}))  { $global:VERBOSE_TRACE = 0 }
if(!(${VERBOSE_LINE}))   { $global:VERBOSE_LINE = 0 }
if(!(${VERBOSE_HALT}))   { $global:VERBOSE_HALT = 0 }

# DEBUG
if(!(${DEBUG_ENABLE}))   { $global:DEBUG_ENABLE = 1 }
if(!(${DEBUG_COLOR}))    { $global:DEBUG_COLOR = ${blue} }
if(!(${DEBUG_TAG}))      { $global:DEBUG_TAG = "DEBUG: " }
if(!(${DEBUG_PAUSE}))    { $global:DEBUG_PAUSE = 0 }
if(!(${DEBUG_TRACE}))    { $global:DEBUG_TRACE = 0 }
if(!(${DEBUG_LINE}))     { $global:DEBUG_LINE = 0 }
if(!(${DEBUG_HALT}))     { $global:DEBUG_HALT = 0 }

# INFO
if(!(${INFO_ENABLE}))    { $global:INFO_ENABLE = 1 }
if(!(${INFO_COLOR}))     { $global:INFO_COLOR = ${white} }
if(!(${INFO_TAG}))       { $global:INFO_TAG = "INFO: " }
if(!(${INFO_PAUSE}))     { $global:INFO_PAUSE = 0 }
if(!(${INFO_TRACE}))     { $global:INFO_TRACE = 0 }
if(!(${INFO_LINE}))      { $global:INFO_LINE = 0 }
if(!(${INFO_HALT}))      { $global:INFO_HALT = 0 }

# NOTICE
if(!(${NOTICE_ENABLE}))  { $global:NOTICE_ENABLE = 1 }
if(!(${NOTICE_COLOR}))   { $global:NOTICE_COLOR = ${lyellow} }
if(!(${NOTICE_TAG}))     { $global:NOTICE_TAG = "NOTICE: " }
if(!(${NOTICE_PAUSE}))   { $global:NOTICE_PAUSE = 0 }
if(!(${NOTICE_TRACE}))   { $global:NOTICE_TRACE = 0 }
if(!(${NOTICE_LINE}))    { $global:NOTICE_LINE = 0 }
if(!(${NOTICE_HALT}))    { $global:NOTICE_HALT = 0 }

# SUCCESS
if(!(${SUCCESS_ENABLE}))  { $global:SUCCESS_ENABLE = 1 }
if(!(${SUCCESS_COLOR}))   { $global:SUCCESS_COLOR = ${green} }
if(!(${SUCCESS_TAG}))     { $global:SUCCESS_TAG = "SUCCESS: " }
if(!(${SUCCESS_PAUSE}))   { $global:SUCCESS_PAUSE = 0 }
if(!(${SUCCESS_TRACE}))   { $global:SUCCESS_TRACE = 0 }
if(!(${SUCCESS_LINE}))    { $global:SUCCESS_LINE = 0 }
if(!(${SUCCESS_HALT}))    { $global:SUCCESS_HALT = 0 }

# WARNING
if(!(${WARNING_ENABLE})) { $global:WARNING_ENABLE = 1 }
if(!(${WARNING_COLOR}))  { $global:WARNING_COLOR = ${yellow} }
if(!(${WARNING_TAG}))    { $global:WARNING_TAG = "WARNING: " }
if(!(${WARNING_PAUSE}))  { $global:WARNING_PAUSE = 0 }
if(!(${WARNING_TRACE}))  { $global:WARNING_TRACE = 0 }
if(!(${WARNING_LINE}))   { $global:WARNING_LINE = 0 }
if(!(${WARNING_HALT}))   { $global:WARNING_HALT = 0 }

# ERROR
if(!(${ERROR_ENABLE}))   { $global:ERROR_ENABLE = 1 }
if(!(${ERROR_COLOR}))    { $global:ERROR_COLOR = ${red} }
if(!(${ERROR_TAG}))      { $global:ERROR_TAG = "ERROR: " }
if(!(${ERROR_PAUSE}))    { $global:ERROR_PAUSE = 1 }
if(!(${ERROR_TRACE}))    { $global:ERROR_TRACE = 0 }
if(!(${ERROR_LINE}))     { $global:ERROR_LINE = 0 }
if(!(${ERROR_HALT}))     { $global:ERROR_HALT = 0 }

# TODO
if(!(${TODO_ENABLE}))    { $global:TODO_ENABLE = 1 }
if(!(${TODO_COLOR}))     { $global:TODO_COLOR = ${lblue} }
if(!(${TODO_TAG}))       { $global:TODO_TAG = "TODO: " }
if(!(${TODO_PAUSE}))     { $global:TODO_PAUSE = 1 }
if(!(${TODO_TRACE}))     { $global:TODO_TRACE = 0 }
if(!(${TODO_LINE}))      { $global:TODO_LINE = 0 }
if(!(${TODO_HALT}))      { $global:TODO_HALT = 0 }

# FIXME
if(!(${FIXME_ENABLE}))   { $global:FIXME_ENABLE = 1 }
if(!(${FIXME_COLOR}))    { $global:FIXME_COLOR = ${lred} }
if(!(${FIXME_TAG}))      { $global:FIXME_TAG = "FIXME: " }
if(!(${FIXME_PAUSE}))    { $global:FIXME_PAUSE = 1 }
if(!(${FIXME_TRACE}))    { $global:FIXME_TRACE = 0 }
if(!(${FIXME_LINE}))     { $global:FIXME_LINE = 0 }
if(!(${FIXME_HALT}))     { $global:FIXME_HALT = 0 }


################################################################################
# dk_debug(message)
#
#    Print a debug message to the console
#
#    @message	- The message to print
#
function Global:dk_log($_level_, $_message_) {
	dk_debugFunc 1 2

	if(${ENABLE_dk_log} -ne 1){ return }
	
	#echo "_level_ = $_level_"
	#echo "_message_ = $_message_"
	if("${_message_}" -eq ""){
		$_message_ = "${_level_}"
		$_level_ = "DEFAULT";
	}
	#if(!(Test-Path variable:echo_fileline)){ $global:echo_fileline = "$(__FILE__ 1):$(__LINE__ 1)   " }

	${level_ENABLE} = Get-Variable "${_level_}_ENABLE" -valueOnly -ErrorAction SilentlyContinue
	${level_COLOR} = Get-Variable "${_level_}_COLOR" -valueOnly -ErrorAction SilentlyContinue
	${level_PAUSE} = Get-Variable "${_level_}_PAUSE" -valueOnly -ErrorAction SilentlyContinue
	${level_TAG} = Get-Variable "${_level_}_TAG" -valueOnly -ErrorAction SilentlyContinue
	${level_TRACE} = Get-Variable "${_level_}_TRACE" -valueOnly -ErrorAction SilentlyContinue
	${level_LINE} = Get-Variable "${_level_}_LINE" -valueOnly -ErrorAction SilentlyContinue
	${level_HALT} = Get-Variable "${_level_}_HALT" -valueOnly -ErrorAction SilentlyContinue
	if("${level_ENABLE}" -ne "1"){ return }

	dk_call dk_echo "${level_COLOR}${level_TAG}${_message_}${clr}"
	if(${level_TRACE} -eq 1){ dk_call dk_echo "${level_COLOR}*** TRACE_ON_${_level_} ***${clr}"; dk_call dk_stacktrace } #OR TRACE AND NOT NO_TRACE)
	if(${level_LINE} -eq 1){  dk_call dk_echo "${level_COLOR}*** LINE_ON_${_level_} ***${clr}"; dk_call dk_showFileLine "${BASH_SOURCE[1]}" "${BASH_LINENO[1-1]}"; } #OR HALT AND NOT NO_HALT)
	if(${level_PAUSE} -eq 1){ dk_call dk_echo "${level_COLOR}*** PAUSE_ON_${_level_} ***${clr}"; dk_call dk_pause }
	if(${level_HALT} -eq 1){  dk_call dk_echo "${level_COLOR}*** HALT_ON_${_level_} ***${clr}"; dk_call dk_exit 0 } #OR HALT AND NOT NO_HALT)
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	echo "dk_log TEST"
	
	dk_debugFunc 0
	
	dk_log "test dk_log message"
	
	dk_call dk_log VERBOSE "test dk_log VERBOSE message"
	dk_call dk_log DEBUG   "test dk_log DEBUG message"
	dk_call dk_log INFO    "test dk_log INFO message"
	dk_call dk_log NOTICE  "test dk_log NOTICE message"
	dk_call dk_log SUCCESS "test dk_log SUCCESS message"
	dk_call dk_log WARNING "test dk_log WARNING message"
	dk_call dk_log TODO    "test dk_log TODO message"
	dk_call dk_log FIXME   "test dk_log FIXME message"
	dk_call dk_log ERROR   "test dk_log ERROR message"
}
