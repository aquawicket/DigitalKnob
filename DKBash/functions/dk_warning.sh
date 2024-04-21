# dk_include_guard()


[ -z $ENABLE_dk_warning ] && ENABLE_dk_warning=1
[ -z $TRACE_ON_WARNING ]  && TRACE_ON_WARNING=0
[ -z $PAUSE_ON_WARNING ]  && PAUSE_ON_WARNING=0
[ -z $HALT_ON_WARNING ]   && HALT_ON_WARNING=0
#TAG="  WARNING: "
##################################################################################
# dk_warning(<message>)
#
#	Print a warning message to the console
#
#	@msg	- The message to print
#
dk_warning () {
	#dk_verbose "dk_warning($*)"	
	
	[ $ENABLE_dk_warning -eq 1 ] || return 0
	msg="$1"
	dk_to_variable_info msg
	
	dk_echo "${yellow}${TAG}${msg}${clr}"
	[ $TRACE_ON_WARNING -eq 1 ] && dk_stacktrace #OR TRACE AND NOT NO_TRACE)			
	[ $HALT_ON_WARNING -eq 1 ] && exec $SHELL #OR HALT AND NOT NO_HALT)
	[ $PAUSE_ON_WARNING -eq 1 ] && dk_pause #OR PAUSE AND NOT NO_PAUSE)
}