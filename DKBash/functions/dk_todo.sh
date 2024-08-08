#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

TODO_TAG="  TODO: "
##################################################################################
# dk_todo(<message>)
#
#	Print a todo message to the console
#
#	@msg	- The message to print
#
dk_todo() {
	dk_debugFunc	
	
	[ ${ENABLE_dk_todo-1} -ne 1 ] && return
	msg="${1-}"
	
	[ -z ${echo_fileline-} ] && export echo_fileline="$(__FILE__ 1):$(__LINE__ 1)   "
	dk_echo "${yellow}${TODO_TAG-}${msg}${clr}"
	
	[ ${TRACE_ON_TODO-0} -eq 1 ] && dk_echo "\n${red}*** TRACE_ON_TODO ***${clr}" && dk_stacktrace; true #OR TRACE AND NOT NO_TRACE)
	[ ${LINE_ON_TODO-0} -eq 1 ]  && dk_echo "\n${red}*** LINE_ON_TODO ***${clr}"  && dk_showFileLine "${BASH_SOURCE[1]}" "${BASH_LINENO[0]}"; true #OR HALT AND NOT NO_HALT)
	[ ${PAUSE_ON_TODO-0} -eq 1 ] && dk_echo "\n${red}*** PAUSE_ON_TODO ***${clr}" && dk_pause; true #OR PAUSE AND NOT NO_PAUSE)
	[ ${HALT_ON_TODO-0} -eq 1 ]  && dk_echo "\n${red}*** HALT_ON_TODO ***${clr}"  && dk_exit; true #OR HALT AND NOT NO_HALT)
}







DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc
	
	dk_todo "test dk_todo message"
}
