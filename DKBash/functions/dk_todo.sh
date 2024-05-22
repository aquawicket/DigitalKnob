#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


[ -z ${ENABLE_dk_todo-} ] && export ENABLE_dk_todo=1
[ -z ${TRACE_ON_TODO-} ]  && export TRACE_ON_TODO=0
[ -z ${LINE_ON_TODO-} ]   && export LINE_ON_TODO=0
[ -z ${PAUSE_ON_TODO-} ]  && export PAUSE_ON_TODO=0
[ -z ${HALT_ON_TODO-} ]   && export HALT_ON_TODO=0
[ -z ${TODO_TAG-} ]       && export TODO_TAG=""
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
	dk_echo "${yellow}${TODO_TAG}${msg}${clr}"
	
	[ $TRACE_ON_TODO -eq 1 ] && dk_echo "\n${red}*** TRACE_ON_TODO ***${clr}" && dk_stacktrace #OR TRACE AND NOT NO_TRACE)
	[ $LINE_ON_TODO -eq 1 ]  && dk_echo "\n${red}*** LINE_ON_TODO ***${clr}"  && dk_showFileLine "${BASH_SOURCE[1]}" "${BASH_LINENO[1-1]}" #OR HALT AND NOT NO_HALT)
	[ $PAUSE_ON_TODO -eq 1 ] && dk_echo "\n${red}*** PAUSE_ON_TODO ***${clr}" && dk_pause #OR PAUSE AND NOT NO_PAUSE)
	[ $HALT_ON_TODO -eq 1 ]  && dk_echo "\n${red}*** HALT_ON_TODO ***${clr}"  && dk_exit #OR HALT AND NOT NO_HALT)
}







DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_todo "test dk_todo message"
	dk_info "...next line..."

}
