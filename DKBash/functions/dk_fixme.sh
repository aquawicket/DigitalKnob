#!/bin/sh
#. ./DK.sh
dk_includeGuard

[ -z ${ENABLE_dk_fixme-} ] && ENABLE_dk_fixme=1
[ -z ${TRACE_ON_FIXME-} ]  && TRACE_ON_FIXME=0
[ -z ${LINE_ON_FIXME-} ]   && LINE_ON_FIXME=0
[ -z ${PAUSE_ON_FIXME-} ]  && PAUSE_ON_FIXME=0
[ -z ${HALT_ON_FIXME-} ]   && HALT_ON_FIXME=0
#FIX_TAG="  FIXME: "
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
	#dk_toVariableInfo msg
	
	dk_echo "${yellow}${TAG}${msg}${clr}"
	[ $TRACE_ON_FIXME -eq 1 ] && dk_echo "\n${red}*** TRACE_ON_FIXME ***${clr}" && dk_stacktrace #OR TRACE AND NOT NO_TRACE)
	[ $LINE_ON_FIXME -eq 1 ]  && dk_echo "\n${red}*** LINE_ON_FIXME ***${clr}"  && dk_showFileLine "${BASH_SOURCE[1]}" "$msg" #OR HALT AND NOT NO_HALT)
	[ $HALT_ON_FIXME -eq 1 ]  && dk_echo "\n${red}*** HALT_ON_FIXME ***${clr}"  && dk_exit #OR HALT AND NOT NO_HALT)
	[ $PAUSE_ON_FIXME -eq 1 ] && dk_echo "\n${red}*** PAUSE_ON_FIXME ***${clr}" && dk_pause #OR PAUSE AND NOT NO_PAUSE)
}