#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

[ -z ${ENABLE_dk_error-} ] && export ENABLE_dk_error=1
[ -z ${TRACE_ON_ERROR-} ]  && export TRACE_ON_ERROR=1
[ -z ${LINE_ON_ERROR-} ]   && export LINE_ON_ERROR=1
[ -z ${PAUSE_ON_ERROR-} ]  && export PAUSE_ON_ERROR=1
[ -z ${HALT_ON_ERROR-} ]   && export HALT_ON_ERROR=1
[ -z ${ERROR_TAG-} ]       && export ERROR_TAG=""
##################################################################################
# dk_error(<message>)
#
#	Print a error message to the console
#
#	@msg	- The message to print
#
dk_error () {
	dk_debugFunc

	[ ${ENABLE_dk_error} -ne 1 ] && return
	msg="$1"
	dk_echo "${red-}${ERROR_TAG}${msg}${clr-}"

	[ ${TRACE_ON_ERROR} -eq 1 ] && dk_echo "\n${red}*** TRACE_ON_ERROR ***${clr}" && dk_load dk_stacktrace && dk_stacktrace; true          #OR TRACE AND NOT NO_TRACE
	[ ${LINE_ON_ERROR} -eq 1 ]  && dk_echo "\n${red}*** LINE_ON_ERROR ***${clr}"  && dk_load dk_showFileLine && dk_showFileLine "${BASH_SOURCE[1]}" "${BASH_LINENO[1-1]}"; true
	[ ${PAUSE_ON_ERROR} -eq 1 ] && dk_echo "\n${red}*** PAUSE_ON_ERROR ***${clr}" && dk_load dk_pause && dk_pause; true                    #OR PAUSE AND NOT NO_PAUSE)
	[ ${HALT_ON_ERROR} -eq 1 ]  && dk_echo "\n${red}*** HALT_ON_ERROR ***${clr}"  && dk_load dk_exit && dk_exit; true                      #OR HALT AND NOT NO_HALT)
}




DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_echo "test dk_echo message"
	dk_error "test dk_error message"
	echo "...next line..."
	
}