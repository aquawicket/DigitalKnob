#!/bin/sh
[ -z "$DKINIT" ] && . ./DK.sh
#dk_includeGuard

[ -z ${ENABLE_dk_info-} ] && ENABLE_dk_info=1
[ -z ${TRACE_ON_INFO-} ]  && TRACE_ON_INFO=0
[ -z ${LINE_ON_INFO-} ]   && LINE_ON_INFO=0
[ -z ${PAUSE_ON_INFO-} ]  && PAUSE_ON_INFO=0
[ -z ${HALT_ON_INFO-} ]   && HALT_ON_INFO=0
#INFO_TAG="  INFO: "
##################################################################################
# dk_info(<message>)
#
#	Print a info message to the console
#
#	@msg	- The message to print
#
dk_info () {
	#dk_debugFunc
	
	[ $ENABLE_dk_debug -ne 1 ] && return
	msg="$1"
	#dk_toVariableInfo msg
	
	dk_echo "${white}${INFO_TAG}${msg}${clr}"
	[ $TRACE_ON_INFO -eq 1 ] && dk_echo "\n${red}*** TRACE_ON_INFO ***${clr}" && dk_stacktrace #OR TRACE AND NOT NO_TRACE)
	[ $LINE_ON_INFO -eq 1 ]  && dk_echo "\n${red}*** LINE_ON_INFO ***${clr}"  && dk_showFileLine "${BASH_SOURCE[1]}" "$msg" #OR HALT AND NOT NO_HALT)
	[ $HALT_ON_INFO -eq 1 ]  && dk_echo "\n${red}*** HALT_ON_INFO ***${clr}"  && dk_exit #OR HALT AND NOT NO_HALT)
	[ $PAUSE_ON_INFO -eq 1 ] && dk_echo "\n${red}*** PAUSE_ON_INFO ***${clr}" && dk_pause #OR PAUSE AND NOT NO_PAUSE)
}




################################ DKTEST #########################################
DKTEST () {

	dk_info "test dk_info message"
	echo "...next line..."
	exec $SHELL
}
[ -n "$DKTEST" ] && DKTEST