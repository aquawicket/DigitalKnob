dk_includeGuard


[ -z ${ENABLE_dk_info-} ] && ENABLE_dk_info=1
[ -z ${TRACE_ON_INFO-} ]  && TRACE_ON_INFO=0
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
	
	dk_echo "${white}${INFO_TAG}${msg}"
	[ $TRACE_ON_INFO -eq 1 ] && dk_stacktrace #OR TRACE AND NOT NO_TRACE)		
	dk_echo "${clr}"	
	[ $HALT_ON_INFO -eq 1 ]  && dk_echo "${white}*** HALT_ON_INFO ***${clr}" && exec $SHELL #OR HALT AND NOT NO_HALT)
	[ $PAUSE_ON_INFO -eq 1 ] && dk_pause #OR PAUSE AND NOT NO_PAUSE)
}