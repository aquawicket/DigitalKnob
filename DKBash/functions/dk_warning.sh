dk_includeGuard


[ -z ${ENABLE_dk_warning-} ] && ENABLE_dk_warning=1
[ -z ${TRACE_ON_WARNING-} ]  && TRACE_ON_WARNING=0
[ -z ${LINE_ON_WARNING-} ]   && LINE_ON_WARNING=0
[ -z ${PAUSE_ON_WARNING-} ]  && PAUSE_ON_WARNING=0
[ -z ${HALT_ON_WARNING-} ]   && HALT_ON_WARNING=0
#WARNING_TAG="  WARNING: "
##################################################################################
# dk_warning(<message>)
#
#	Print a warning message to the console
#
#	@msg	- The message to print
#
dk_warning () {
	#dk_debugFunc
	
	[ $ENABLE_dk_warning -ne 1 ] && return
	msg="$1"
	#dk_toVariableInfo msg
	
	dk_echo "${yellow}${WARNING_TAG}${msg}${clr}"
	[ $TRACE_ON_WARNING -eq 1 ] && dk_echo "\n${red}*** TRACE_ON_WARNING ***${clr}" && dk_stacktrace #OR TRACE AND NOT NO_TRACE)
	[ $LINE_ON_WARNING -eq 1 ]  && dk_echo "\n${red}*** LINE_ON_WARNING ***${clr}"  && dk_showFileLine "${BASH_SOURCE[1]}" "$msg" #OR HALT AND NOT NO_HALT)
	[ $HALT_ON_WARNING -eq 1 ]  && dk_echo "\n${red}*** HALT_ON_WARNING ***${clr}"  && dk_exit #OR HALT AND NOT NO_HALT)
	[ $PAUSE_ON_WARNING -eq 1 ] && dk_echo "\n${red}*** PAUSE_ON_WARNING ***${clr}" && dk_pause #OR PAUSE AND NOT NO_PAUSE)
}