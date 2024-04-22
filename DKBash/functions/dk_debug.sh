# dk_includeGuard()


[ -z $ENABLE_dk_debug ] && ENABLE_dk_debug=1
[ -z $TRACE_ON_DEBUG ]  && TRACE_ON_DEBUG=0
[ -z $PAUSE_ON_DEBUG ]  && PAUSE_ON_DEBUG=0
[ -z $HALT_ON_DEBUG ]   && HALT_ON_DEBUG=0
#TAG="  DEBUG: "
##################################################################################
# dk_debug(<message>)
#
#	Print a debug message to the console
#
#	@msg	- The message to print
#
dk_debug () {
	#dk_verbose "dk_debug($*)"	
	
	[ $ENABLE_dk_debug -eq 1 ] || return 0
	msg="$1"
	dk_toVariableInfo msg
	
	dk_echo "${blue}${TAG}${msg}${clr}"
	[ $TRACE_ON_DEBUG -eq 1 ] && dk_stacktrace #OR TRACE AND NOT NO_TRACE)			
	[ $HALT_ON_DEBUG -eq 1 ] && exec $SHELL #OR HALT AND NOT NO_HALT)
	[ $PAUSE_ON_DEBUG -eq 1 ] && dk_pause #OR PAUSE AND NOT NO_PAUSE)
}