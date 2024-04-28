dk_includeGuard


[ -z ${ENABLE_dk_todo-} ] && ENABLE_dk_todo=1
[ -z ${TRACE_ON_TODO-} ]  && TRACE_ON_TODO=0
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
	[ $TRACE_ON_TODO -eq 1 ] && dk_stacktrace #OR TRACE AND NOT NO_TRACE)
	dk_echo "${clr}"	
	[ $HALT_ON_TODO -eq 1 ] && dk_echo "${yellow}*** HALT_ON_TODO ***${clr}" && exec $SHELL #OR HALT AND NOT NO_HALT)
	[ $PAUSE_ON_TODO -eq 1 ] && dk_pause #OR PAUSE AND NOT NO_PAUSE)
}