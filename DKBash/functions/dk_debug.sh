#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

#dk_set ENABLE_dk_debug 0
#dk_set TRACE_ON_DEBUG 1
#dk_set LINE_ON_DEBUG 1
#dk_set PAUSE_ON_DEBUG 1
#dk_set HALT_ON_DEBUG 1
#dk_set DEBUG_TAG " DEBUG: "
##################################################################################
# dk_debug(message)
#
#	Print a debug message to the console
#
#	@msg	- The message to print
#
dk_debug (){
	dk_debugFunc
	[ $# -ne 1 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	
	
	[ ${ENABLE_dk_debug-1} -ne 1 ] && return
	msg="${1}"
	
	[ -z ${echo_fileline-} ] && export echo_fileline="$(__FILE__ 1):$(__LINE__ 1)   "
	dk_echo "${blue-}${DEBUG_TAG-}${msg}${clr-}"
	[ ${TRACE_ON_DEBUG-0} -eq 1 ] && dk_echo "${blue}*** TRACE_ON_DEBUG ***${clr}" && dk_stacktrace; true #OR TRACE AND NOT NO_TRACE)
	[ ${LINE_ON_DEBUG-0} -eq 1 ]  && dk_echo "${blue}*** LINE_ON_DEBUG ***${clr}"  && dk_showFileLine "${BASH_SOURCE[1]}" "${BASH_LINENO[1-1]}"; true #OR HALT AND NOT NO_HALT)
	[ ${PAUSE_ON_DEBUG-0} -eq 1 ] && dk_echo "${blue}*** PAUSE_ON_DEBUG ***${clr}" && dk_pause; true #OR PAUSE AND NOT NO_PAUSE)
	[ ${HALT_ON_DEBUG-0} -eq 1 ]  && dk_echo "${blue}*** HALT_ON_DEBUG ***${clr}"  && dk_exit; true #OR HALT AND NOT NO_HALT)
}








DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dk_debug "test dk_debug message"
}