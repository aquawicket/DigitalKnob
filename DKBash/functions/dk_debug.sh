#!/bin/sh
[ -z "$DKINIT" ] && . ./DK.sh
dk_includeGuard


[ -z ${ENABLE_dk_debug-} ] && ENABLE_dk_debug=1
[ -z ${TRACE_ON_DEBUG-} ]  && TRACE_ON_DEBUG=0
[ -z ${LINE_ON_DEBUG-} ]   && LINE_ON_DEBUG=0
[ -z ${PAUSE_ON_DEBUG-} ]  && PAUSE_ON_DEBUG=0
[ -z ${HALT_ON_DEBUG-} ]   && HALT_ON_DEBUG=0
#DEBUG_TAG="  DEBUG: "
##################################################################################
# dk_debug(<message>)
#
#	Print a debug message to the console
#
#	@msg	- The message to print
#
dk_debug () {
	#dk_debugFunc
	
	[ $ENABLE_dk_debug -ne 1 ] && return
	msg="$1"
	dk_toVariableInfo msg
	
	dk_echo "${blue}${DEBUG_TAG}${msg}${clr}"
	[ $TRACE_ON_DEBUG -eq 1 ] && dk_echo "\n${red}*** TRACE_ON_DEBUG ***${clr}" && dk_stacktrace #OR TRACE AND NOT NO_TRACE)
	[ $LINE_ON_DEBUG -eq 1 ]  && dk_echo "\n${red}*** LINE_ON_DEBUG ***${clr}"  && dk_showFileLine "${BASH_SOURCE[1]}" "$msg" #OR HALT AND NOT NO_HALT)
	[ $HALT_ON_DEBUG -eq 1 ]  && dk_echo "\n${red}*** HALT_ON_DEBUG ***${clr}"  && dk_exit #OR HALT AND NOT NO_HALT)
	[ $PAUSE_ON_DEBUG -eq 1 ] && dk_echo "\n${red}*** PAUSE_ON_DEBUG ***${clr}" && dk_pause #OR PAUSE AND NOT NO_PAUSE)
}




################################ DKTEST #########################################
DKTEST_START

	dk_debug "test dk_debug message"
	echo "...next line..."
	
DKTEST_END