# dk_includeGuard()


[ -z $ENABLE_dk_error ] && ENABLE_dk_error=1
[ -z $TRACE_ON_ERROR ]  && TRACE_ON_ERROR=1
[ -z $PAUSE_ON_ERROR ]  && PAUSE_ON_ERROR=0
[ -z $HALT_ON_ERROR ]   && HALT_ON_ERROR=1
ERROR_TAG="ERROR: "
##################################################################################
# dk_error(<message>)
#
#	Print a error message to the console
#
#	@msg	- The message to print
#
dk_error () {
	#dk_verbose "dk_error($*)"	
	
	[ $ENABLE_dk_error -eq 1 ] || return 0
	msg="$1"
	dk_toVariableInfo msg
	
	dk_echo "${red}${ERROR_TAG}${bg_red}${msg}${clr}${red}"
	[ $TRACE_ON_ERROR -eq 1 ] && dk_stacktrace #OR TRACE AND NOT NO_TRACE)
	dk_echo "${clr}"	
	[ $HALT_ON_ERROR -eq 1 ] && dk_echo "${red}*** HALT_ON_ERROR ***${clr}" && exec $SHELL #OR HALT AND NOT NO_HALT)
	[ $PAUSE_ON_ERROR -eq 1 ] && dk_pause #OR PAUSE AND NOT NO_PAUSE)
}