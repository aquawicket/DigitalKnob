#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

#dk_set ENABLE_dk_verbose 1
#dk_set TRACE_ON_VERBOSE 1
#dk_set LINE_ON_VERBOSE 1
#dk_set PAUSE_ON_VERBOSE 1
#dk_set HALT_ON_VERBOSE 1
#dk_set VERBOSE_TAG " VERBOSE: "
##################################################################################
# dk_verbose(message)
#
#	Print a verbose message to the console
#
#	@msg	- The message to print
#
dk_verbose() {
	dk_debugFunc 1

	
	
	[ ${ENABLE_dk_verbose-1} -ne 1 ] && return
	msg="${1}"
	
	[ -z ${echo_fileline-} ] && export echo_fileline="$(__FILE__ 1):$(__LINE__ 1)   "
	dk_echo "${cyan}${VERBOSE_TAG-}${msg}${clr}"
	[ ${TRACE_ON_VERBOSE-0} -eq 1 ] && dk_echo "${cyan}*** TRACE_ON_VERBOSE ***${clr}"  && dk_stacktrace; true #OR TRACE AND NOT NO_TRACE)
	[ ${LINE_ON_VERBOSE-0} -eq 1 ]  && dk_echo "${cyan}*** LINE_ON_VERBOSE ***${clr}"   && dk_showFileLine "${BASH_SOURCE[1]}" "${BASH_LINENO[0]}"; true #OR HALT AND NOT NO_HALT)
	[ ${PAUSE_ON_VERBOSE-0} -eq 1 ] && dk_echo "${cyan}*** PAUSE_ON_VERBOSE ***${clr}"  && dk_pause; true #OR PAUSE AND NOT NO_PAUSE)
	[ ${HALT_ON_VERBOSE-0} -eq 1 ]  && dk_echo "${cyan}*** HALT_ON_VERBOSE ***${clr}"   && dk_exit; true #OR HALT AND NOT NO_HALT)
}








DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc 0
	
	dk_verbose "test dk_verbose message"
}