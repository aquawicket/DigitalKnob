dk_includeGuard


[ -z ${ENABLE_dk_verbose-} ] && ENABLE_dk_verbose=1
[ -z ${TRACE_ON_VERBOSE-} ]  && TRACE_ON_VERBOSE=0
[ -z ${PAUSE_ON_VERBOSE-} ]  && PAUSE_ON_VERBOSE=0
[ -z ${HALT_ON_VERBOSE-} ]   && HALT_ON_VERBOSE=0
#VERBOSE_TAG="  VERBOSE: "
##################################################################################
# dk_verbose(<message>)
#
#	Print a verbose message to the console
#
#	@msg	- The message to print
#
dk_verbose () {
	#dk_debugFunc
	
	[ $ENABLE_dk_verbose -ne 1 ] && return
	msg="$1"
	#dk_toVariableInfo msg
	
	dk_echo "${cyan}${VERBOSE_TAG}${msg}"
	[ $TRACE_ON_VERBOSE -eq 1 ] && dk_stacktrace #OR TRACE AND NOT NO_TRACE)	
    dk_echo "${clr}"
	[ $HALT_ON_VERBOSE -eq 1 ]  && dk_echo "${cyan}*** HALT_ON_VERBOSE ***${clr}" && exec $SHELL #OR HALT AND NOT NO_HALT)
	[ $PAUSE_ON_VERBOSE -eq 1 ] && dk_pause #OR PAUSE AND NOT NO_PAUSE)
}