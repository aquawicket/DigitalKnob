#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

[ -z ${ENABLE_dk_debug-} ] && export ENABLE_dk_debug=1
[ -z ${TRACE_ON_DEBUG-} ]  && export TRACE_ON_DEBUG=0
[ -z ${LINE_ON_DEBUG-} ]   && export LINE_ON_DEBUG=0
[ -z ${PAUSE_ON_DEBUG-} ]  && export PAUSE_ON_DEBUG=0
[ -z ${HALT_ON_DEBUG-} ]   && export HALT_ON_DEBUG=0
[ -z ${DEBUG_TAG-} ]       && export DEBUG_TAG=""
##################################################################################
# dk_debug(<message>)
#
#	Print a debug message to the console
#
#	@msg	- The message to print
#
dk_debug () {
	dk_debugFunc

	[ ${ENABLE_dk_debug} -ne 1 ] && return
	msg="$1"
	dk_echo "${blue-}${DEBUG_TAG}${msg}${clr-}"

	[ ${TRACE_ON_DEBUG} -eq 1 ] && dk_echo "\n${blue}*** TRACE_ON_DEBUG ***${clr}" && dk_stacktrace & #OR TRACE AND NOT NO_TRACE)
	[ ${LINE_ON_DEBUG} -eq 1 ]  && dk_echo "\n${blue}*** LINE_ON_DEBUG ***${clr}"  && dk_showFileLine "${BASH_SOURCE[1]}" "${BASH_LINENO[1-1]}" & #OR HALT AND NOT NO_HALT)
	[ ${PAUSE_ON_DEBUG} -eq 1 ] && dk_echo "\n${blue}*** PAUSE_ON_DEBUG ***${clr}" && dk_pause & #OR PAUSE AND NOT NO_PAUSE)
	[ ${HALT_ON_DEBUG} -eq 1 ]  && dk_echo "\n${blue}*** HALT_ON_DEBUG ***${clr}"  && dk_exit & #OR HALT AND NOT NO_HALT)
}




DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_echo "test dk_echo message"
	dk_debug "test dk_debug message"
	echo "...next line..."
	
}