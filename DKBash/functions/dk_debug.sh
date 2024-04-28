dk_includeGuard


[ -z ${ENABLE_dk_debug-} ] && ENABLE_dk_debug=1
[ -z ${TRACE_ON_DEBUG-} ]  && TRACE_ON_DEBUG=0
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
	
	dk_echo "${blue}${DEBUG_TAG}${msg}"
	[ $TRACE_ON_DEBUG -eq 1 ] && dk_stacktrace #OR TRACE AND NOT NO_TRACE)
    dk_echo "${clr}"
	[ $HALT_ON_DEBUG -eq 1 ]  && dk_echo "${blue}*** HALT_ON_DEBUG ***${clr}" && exec $SHELL #OR HALT AND NOT NO_HALT)
	[ $PAUSE_ON_DEBUG -eq 1 ] && dk_pause #OR PAUSE AND NOT NO_PAUSE)
}