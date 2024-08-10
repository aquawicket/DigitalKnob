#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


[ -z ${ENABLE_dk_debug-} ] && ENABLE_dk_debug=1
[ -z ${PAUSE_ON_DEBUG-} ]  && PAUSE_ON_DEBUG=0
[ -z ${TRACE_ON_DEBUG-} ]  && TRACE_ON_DEBUG=0
[ -z ${LINE_ON_DEBUG-} ]   && LINE_ON_DEBUG=0
[ -z ${HALT_ON_DEBUG-} ]   && HALT_ON_DEBUG=0
[ -z ${DEBUG_TAG-} ]       && DEBUG_TAG="DEBUG: "
##################################################################################
# dk_debug(message)
#
#	Print a debug message to the console
#
#	@msg	- The message to print
#
dk_debug() {
	dk_debugFunc 1

	[ ${ENABLE_dk_debug-1} -ne 1 ] && return
	msg="${1}"
	
	[ -z ${echo_fileline-} ] && export echo_fileline="$(__FILE__ 1):$(__LINE__ 1)   "
	dk_echo "${blue-}${DEBUG_TAG-}${msg}${clr-}"
	[ ${PAUSE_ON_DEBUG-0} -eq 1 ] && dk_echo "${blue}*** PAUSE_ON_DEBUG ***${clr}" && dk_pause; true #OR PAUSE AND NOT NO_PAUSE)
	[ ${TRACE_ON_DEBUG-0} -eq 1 ] && dk_echo "${blue}*** TRACE_ON_DEBUG ***${clr}" && dk_stacktrace; true #OR TRACE AND NOT NO_TRACE)
	[ ${LINE_ON_DEBUG-0} -eq 1 ]  && dk_echo "${blue}*** LINE_ON_DEBUG ***${clr}"  && dk_showFileLine "${BASH_SOURCE[1]}" "${BASH_LINENO[1-1]}"; true #OR HALT AND NOT NO_HALT)
	[ ${HALT_ON_DEBUG-0} -eq 1 ]  && dk_echo "${blue}*** HALT_ON_DEBUG ***${clr}"  && dk_exit; true #OR HALT AND NOT NO_HALT)
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
	dk_debugFunc 0
	
	dk_debug "test dk_debug message"
}