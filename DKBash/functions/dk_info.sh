# dk_includeGuard()


[ -z $ENABLE_dk_info ] && ENABLE_dk_info=1
[ -z $TRACE_ON_INFO ]  && TRACE_ON_INFO=0
[ -z $PAUSE_ON_INFO ]  && PAUSE_ON_INFO=0
[ -z $HALT_ON_INFO ]   && HALT_ON_INFO=0
#TAG="  INFO: "
##################################################################################
# dk_info(<message>)
#
#	Print a info message to the console
#
#	@msg	- The message to print
#
dk_info () {
	dk_debugFunc
	
	[ $ENABLE_dk_debug -eq 1 ] || return 0
	msg="$1"
	dk_toVariableInfo msg
	
	dk_echo "${white}${TAG}${msg}${clr}"
	[ $TRACE_ON_INFO -eq 1 ] && dk_stacktrace #OR TRACE AND NOT NO_TRACE)			
	[ $HALT_ON_INFO -eq 1 ] && exec $SHELL #OR HALT AND NOT NO_HALT)
	[ $PAUSE_ON_INFO -eq 1 ] && dk_pause #OR PAUSE AND NOT NO_PAUSE)
}