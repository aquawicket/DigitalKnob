#!/bin/sh
[ -z "$DKINIT" ] && . ./DK.sh
#dk_includeGuard


[ -z ${ENABLE_dk_todo-} ] && ENABLE_dk_todo=1
[ -z ${TRACE_ON_TODO-} ]  && TRACE_ON_TODO=0
[ -z ${LINE_ON_TODO-} ]   && LINE_ON_TODO=0
[ -z ${PAUSE_ON_TODO-} ]  && PAUSE_ON_TODO=0
[ -z ${HALT_ON_TODO-} ]   && HALT_ON_TODO=0
#TODO_TAG="  TODO: "
##################################################################################
# dk_todo(<message>)
#
#	Print a todo message to the console
#
#	@msg	- The message to print
#
dk_todo () {
	#dk_debugFunc	
	
	[ $ENABLE_dk_todo -ne 1 ] && return
	msg="$1"
	#dk_toVariableInfo msg
	
	dk_echo "${yellow}${TODO_TAG}${msg}${clr}"
	[ $TRACE_ON_TODO -eq 1 ] && dk_echo "\n${red}*** TRACE_ON_TODO ***${clr}" && dk_stacktrace #OR TRACE AND NOT NO_TRACE)
	[ $LINE_ON_TODO -eq 1 ]  && dk_echo "\n${red}*** LINE_ON_TODO ***${clr}"  && dk_showFileLine "${BASH_SOURCE[1]}" "$msg" #OR HALT AND NOT NO_HALT)
	[ $HALT_ON_TODO -eq 1 ]  && dk_echo "\n${red}*** HALT_ON_TODO ***${clr}"  && dk_exit #OR HALT AND NOT NO_HALT)
	[ $PAUSE_ON_TODO -eq 1 ] && dk_echo "\n${red}*** PAUSE_ON_TODO ***${clr}" && dk_pause #OR PAUSE AND NOT NO_PAUSE)
}







################################ DKTEST #########################################
DKTEST () {

	dk_todo "test dk_todo message"
	dk_info "...next line..."

	exec $SHELL
}
[ -n "$DKTEST" ] && DKTEST