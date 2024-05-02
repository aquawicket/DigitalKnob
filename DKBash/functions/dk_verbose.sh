#!/bin/sh
[ -z "$DKINIT" ] && . ./DK.sh
#dk_includeGuard


[ -z ${ENABLE_dk_verbose-} ] && ENABLE_dk_verbose=1
[ -z ${TRACE_ON_VERBOSE-} ]  && TRACE_ON_VERBOSE=0
[ -z ${LINE_ON_VERBOSE-} ]   && LINE_ON_VERBOSE=0
[ -z ${PAUSE_ON_VERBOSE-} ]  && PAUSE_ON_VERBOSE=0
[ -z ${HALT_ON_VERBOSE-} ]   && HALT_ON_VERBOSE=0
#VERBOSE_TAG="  VERBOSE: "
##################################################################################
# dk_verbose(<message>)
#
#	Print a verbose message to the console
#
#	@msg	- The message to print
#
dk_verbose () {
	#dk_debugFunc
	
	[ $ENABLE_dk_verbose -ne 1 ] && return
	msg="$1"
	#dk_toVariableInfo msg
	
	dk_echo "${cyan}${VERBOSE_TAG}${msg}${clr}"
	[ $TRACE_ON_VERBOSE -eq 1 ] && dk_echo "\n${red}*** TRACE_ON_VERBOSE ***${clr}"  && dk_stacktrace #OR TRACE AND NOT NO_TRACE)
	[ $LINE_ON_VERBOSE -eq 1 ]  && dk_echo "\n${red}*** LINE_ON_VERBOSE ***${clr}"   && dk_showFileLine "${BASH_SOURCE[1]}" "$msg" #OR HALT AND NOT NO_HALT)
	[ $HALT_ON_VERBOSE -eq 1 ]  && dk_echo "\n${red}*** HALT_ON_VERBOSE ***${clr}"   && dk_exit #OR HALT AND NOT NO_HALT)
	[ $PAUSE_ON_VERBOSE -eq 1 ] && dk_echo "\n${red}*** PAUSE_ON_VERBOSE ***${clr}"  && dk_pause #OR PAUSE AND NOT NO_PAUSE)
}





################################ DKTEST #########################################
[ -n "$DKTEST" ] && {

	dk_verbose "test dk_verbose message"
	dk_info "...next line..."

} && exec $SHELL