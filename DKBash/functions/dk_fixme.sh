# dk_includeGuard()


[ -z $ENABLE_dk_fixme ] && ENABLE_dk_fixme=1
[ -z $TRACE_ON_FIXME ]  && TRACE_ON_FIXME=0
[ -z $PAUSE_ON_FIXME ]  && PAUSE_ON_FIXME=0
[ -z $HALT_ON_FIXME ]   && HALT_ON_FIXME=0
#TAG="  FIXME: "
##################################################################################
# dk_fixme(<message>)
#
#	Print a fixme message to the console
#
#	@msg	- The message to print
#
dk_fixme () {
	dk_debugFunc
	
	[ $ENABLE_dk_fixme -eq 1 ] || return 0
	msg="$1"
	dk_toVariableInfo msg
	
	dk_echo "${yellow}${TAG}${msg}${clr}"
	[ $TRACE_ON_FIXME -eq 1 ] && dk_stacktrace #OR TRACE AND NOT NO_TRACE)			
	[ $HALT_ON_FIXME -eq 1 ] && exec $SHELL #OR HALT AND NOT NO_HALT)
	[ $PAUSE_ON_FIXME -eq 1 ] && dk_pause #OR PAUSE AND NOT NO_PAUSE)
}