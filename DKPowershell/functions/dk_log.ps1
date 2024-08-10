if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_log){ $dk_log = 1 } else{ return }


# DEFAULT
if(!(${ENABLE_dk_log}))  { ${ENABLE_dk_log} = 1 }
if(!(${DEFAULT_COLOR})) { ${DEFAULT_COLOR} = ${white} }
#if(!(${DEFAULT_TAG}))  { ${DEFAULT_TAG} = bat>: " }
if(!(${DEFAULT_PAUSE})) { ${DEFAULT_PAUSE} = 0 }
if(!(${DEFAULT_TRACE})) { ${DEFAULT_TRACE} = 0 }
if(!(${DEFAULT_LINE}))  { ${DEFAULT_LINE} = 0 }
if(!(${DEFAULT_HALT}))  { ${DEFAULT_HALT} = 0 }

# VERBOSE
if(!(${VERBOSE_ENABLE})) { ${VERBOSE_ENABLE} = 1 }
if(!(${VERBOSE_COLOR}))  { ${VERBOSE_COLOR} = ${magenta} }
if(!(${VERBOSE_TAG}))    { ${VERBOSE_TAG} = "VERBOSE: " }
if(!(${VERBOSE_PAUSE}))  { ${VERBOSE_PAUSE} = 1 }
if(!(${VERBOSE_TRACE}))  { ${VERBOSE_TRACE} = 0 }
if(!(${VERBOSE_LINE}))   { ${VERBOSE_LINE} = 0 }
if(!(${VERBOSE_HALT}))   { ${VERBOSE_HALT} = 0 }

# DEBUG
if(!(${DEBUG_ENABLE}))   { ${DEBUG_ENABLE} = 1 }
if(!(${DEBUG_COLOR}))    { ${DEBUG_COLOR} = ${blue} }
if(!(${DEBUG_TAG}))      { ${DEBUG_TAG} = "DEBUG: " }
if(!(${DEBUG_PAUSE}))    { ${DEBUG_PAUSE} = 0 }
if(!(${DEBUG_TRACE}))    { ${DEBUG_TRACE} = 0 }
if(!(${DEBUG_LINE}))     { ${DEBUG_LINE} = 0 }
if(!(${DEBUG_HALT}))     { ${DEBUG_HALT} = 0 }

# INFO
if(!(${INFO_ENABLE}))   { ${INFO_ENABLE} = 1 }
if(!(${INFO_COLOR}))    { ${INFO_COLOR} = ${white} }
if(!(${INFO_TAG}))      { ${INFO_TAG} = "INFO: " }
if(!(${INFO_PAUSE}))    { ${INFO_PAUSE} = 0 }
if(!(${INFO_TRACE}))    { ${INFO_TRACE} = 0 }
if(!(${INFO_LINE}))     { ${INFO_LINE} = 0 }
if(!(${INFO_HALT}))     { ${INFO_HALT} = 0 }

# WARNING
if(!(${WARNING_ENABLE}))  { ${WARNING_ENABLE} = 1 }
if(!(${WARNING_COLOR}))    { ${WARNING_COLOR} = ${yellow} }
if(!(${WARNING_TAG}))      { ${WARNING_TAG} = "WARNING: " }
if(!(${WARNING_PAUSE}))    { ${WARNING_PAUSE} = 0 }
if(!(${WARNING_TRACE}))    { ${WARNING_TRACE} = 0 }
if(!(${WARNING_LINE}))     { ${WARNING_LINE} = 0 }
if(!(${WARNING_HALT}))     { ${WARNING_HALT} = 0 }

# ERROR
if(!(${ERROR_ENABLE}))   { ${ERROR_ENABLE} = 1 }
if(!(${ERROR_COLOR}))    { ${ERROR_COLOR} = ${red} }
if(!(${ERROR_TAG}))      { ${ERROR_TAG} = "ERROR: " }
if(!(${ERROR_PAUSE}))    { ${ERROR_PAUSE} = 0 }
if(!(${ERROR_TRACE}))    { ${ERROR_TRACE} = 0 }
if(!(${ERROR_LINE}))     { ${ERROR_LINE} = 0 }
if(!(${ERROR_HALT}))     { ${ERROR_HALT} = 0 }

# TODO
if(!(${TODO_ENABLE}))   { ${TODO_ENABLE} = 1 }
if(!(${TODO_COLOR}))    { ${TODO_COLOR} = ${yellow} }
if(!(${TODO_TAG}))      { ${TODO_TAG} = "TODO: " }
if(!(${TODO_PAUSE}))    { ${TODO_PAUSE} = 0 }
if(!(${TODO_TRACE}))    { ${TODO_TRACE} = 0 }
if(!(${TODO_LINE}))     { ${TODO_LINE} = 0 }
if(!(${TODO_HALT}))     { ${TODO_HALT} = 0 }

# FIXME
if(!(${FIXME_ENABLE}))   { ${FIXME_ENABLE} = 1 }
if(!(${FIXME_COLOR}))    { ${FIXME_COLOR} = ${red} }
if(!(${FIXME_TAG}))      { ${FIXME_TAG} = "FIXME: " }
if(!(${FIXME_PAUSE}))    { ${FIXME_PAUSE} = 0 }
if(!(${FIXME_TRACE}))    { ${FIXME_TRACE} = 0 }
if(!(${FIXME_LINE}))     { ${FIXME_LINE} = 0 }
if(!(${FIXME_HALT}))     { ${FIXME_HALT} = 0 }


################################################################################
# dk_debug(message)
#
#    Print a debug message to the console
#
#    @message	- The message to print
#
function Global:dk_log() {
	#dk_debugFunc 1 2

	if(${ENABLE_dk_log} -ne 1){ return }
	
	
	$arg1 = $args[0]
	$arg2 = $args[1]
	${ARGC} = ${args}.count
	if(${ARGC} -eq 1) {${_level_} = "DEFAULT"; ${_message_} = "${arg1}" }
	if(${ARGC} -eq 2) {${_level_} = ${arg1}; ${_message_} = "${arg2}" }
	#if(!(Test-Path variable:echo_fileline)){ $global:echo_fileline = "$(__FILE__ 1):$(__LINE__ 1)   " }

	${level_ENABLE} = Get-Variable "${_level_}_ENABLE" -valueOnly
	${level_COLOR} = Get-Variable "${_level_}_COLOR" -valueOnly
	${level_PAUSE} = Get-Variable "${_level_}_PAUSE" -valueOnly
	${level_TAG} = Get-Variable "${_level_}_TAG" -valueOnly
	${level_TRACE} = Get-Variable "${_level_}_TRACE" -valueOnly
	${level_LINE} = Get-Variable "${_level_}_LINE" -valueOnly
	${level_HALT} = Get-Variable "${_level_}_HALT" -valueOnly
	if("${level_ENABLE}" -ne "1"){ return }

	
	dk_echo "${level_COLOR}${level_TAG}${_message_}${clr}"
#	if(${level_PAUSE} -eq 1) dk_echo "${level_COLOR}*** PAUSE_ON_DEBUG ***${clr}" dk_pause; true #OR PAUSE AND NOT NO_PAUSE)
#	if(${level_TRACE} -eq 1) dk_echo "${level_COLOR}*** TRACE_ON_DEBUG ***${clr}" && dk_stacktrace; true #OR TRACE AND NOT NO_TRACE)
#	if(${level_LINE} -eq 1)  dk_echo "${level_COLOR}*** LINE_ON_DEBUG ***${clr}"  && dk_showFileLine "${BASH_SOURCE[1]}" "${BASH_LINENO[1-1]}"; true #OR HALT AND NOT NO_HALT)
#	if(${level_HALT} -eq 1)  dk_echo "${level_COLOR}*** HALT_ON_DEBUG ***${clr}"  && dk_exit 0; true #OR HALT AND NOT NO_HALT)
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
#	dk_debugFunc 0
	
#	dk_log "test dk_log message"
	
	dk_log VERBOSE "test dk_log VERBOSE message"
	dk_log DEBUG   "test dk_log DEBUG message"
	dk_log INFO    "test dk_log INFO message"
	dk_log WARNING "test dk_log WARNING message"
	dk_log ERROR   "test dk_log ERROR message"
}
