#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

[ -z ${ENABLE_dk_fixme-} ] && export ENABLE_dk_fixme=1
[ -z ${TRACE_ON_FIXME-} ]  && export TRACE_ON_FIXME=0
[ -z ${LINE_ON_FIXME-} ]   && export LINE_ON_FIXME=0
[ -z ${PAUSE_ON_FIXME-} ]  && export PAUSE_ON_FIXME=0
[ -z ${HALT_ON_FIXME-} ]   && export HALT_ON_FIXME=0
[ -z ${FIXME_TAG-} ]       && export FIXME_TAG=""
##################################################################################
# dk_fixme(<message>)
#
#	Print a fixme message to the console
#
#	@msg	- The message to print
#
dk_fixme () {
	dk_debugFunc
	
	[ ${ENABLE_dk_fixme} -eq 1 ] || return 0
	msg="$1"
	dk_echo "${yellow}${FIXME_TAG}${msg}${clr}"
	
	[ ${TRACE_ON_FIXME} -eq 1 ] && dk_echo "\n${red}*** TRACE_ON_FIXME ***${clr}" && dk_stacktrace; true #OR TRACE AND NOT NO_TRACE)
	[ ${LINE_ON_FIXME} -eq 1 ]  && dk_echo "\n${red}*** LINE_ON_FIXME ***${clr}"  && dk_showFileLine "${BASH_SOURCE[1]}" "${BASH_LINENO[0]}"; true #OR HALT AND NOT NO_HALT)
	[ ${PAUSE_ON_FIXME} -eq 1 ] && dk_echo "\n${red}*** PAUSE_ON_FIXME ***${clr}" && dk_pause; true #OR PAUSE AND NOT NO_PAUSE)
	[ ${HALT_ON_FIXME} -eq 1 ]  && dk_echo "\n${red}*** HALT_ON_FIXME ***${clr}"  && dk_exit; true #OR HALT AND NOT NO_HALT)
}




DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_fixme "test dk_fixme message"
	dk_info "...next line..."
}