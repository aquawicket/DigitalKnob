# dk_include_guard()


[ -z $ENABLE_dk_verbose ] && ENABLE_dk_verbose=1
[ -z $TRACE_ON_VERBOSE ]  && TRACE_ON_VERBOSE=0
[ -z $PAUSE_ON_VERBOSE ]  && PAUSE_ON_VERBOSE=0
[ -z $HALT_ON_VERBOSE ]   && HALT_ON_VERBOSE=0
#TAG="  VERBOSE: "
##################################################################################
# dk_verbose(<message>)
#
#	Print a verbose message to the console
#
#	@msg	- The message to print
#
dk_verbose () {
	#dk_verbose "dk_verbose($*)"	
	
	[ $ENABLE_dk_verbose -eq 1 ] || return 0
	msg="$1"
	dk_to_variable_info msg
	
	dk_echo "${cyan}${TAG}${msg}${clr}"
	[ $TRACE_ON_VERBOSE -eq 1 ] && dk_stacktrace #OR TRACE AND NOT NO_TRACE)			
	[ $HALT_ON_VERBOSE -eq 1 ] && exec $SHELL #OR HALT AND NOT NO_HALT)
	[ $PAUSE_ON_VERBOSE -eq 1 ] && dk_pause #OR PAUSE AND NOT NO_PAUSE)
}