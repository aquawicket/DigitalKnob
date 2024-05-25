#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


[ -z ${ENABLE_dk_warning-} ] && export ENABLE_dk_warning=1
[ -z ${TRACE_ON_WARNING-} ]  && export TRACE_ON_WARNING=0
[ -z ${LINE_ON_WARNING-} ]   && export LINE_ON_WARNING=0
[ -z ${PAUSE_ON_WARNING-} ]  && export PAUSE_ON_WARNING=0
[ -z ${HALT_ON_WARNING-} ]   && export HALT_ON_WARNING=0
[ -z ${WARNING_TAG-} ]       && export WARNING_TAG=""
##################################################################################
# dk_warning(<message>)
#
#	Print a warning message to the console
#
#	@msg	- The message to print
#
dk_warning () {
	dk_debugFunc
	
	[ $ENABLE_dk_warning -ne 1 ] && return
	msg="$1"
	dk_echo "${yellow}${WARNING_TAG}${msg}${clr}"

	[ $TRACE_ON_WARNING -eq 1 ] && dk_echo "\n${red}*** TRACE_ON_WARNING ***${clr}" && dk_stacktrace; true #OR TRACE AND NOT NO_TRACE)
	[ $LINE_ON_WARNING -eq 1 ]  && dk_echo "\n${red}*** LINE_ON_WARNING ***${clr}"  && dk_showFileLine "${BASH_SOURCE[1]}" "${BASH_LINENO[1-1]}"; true #OR HALT AND NOT NO_HALT)
	[ $PAUSE_ON_WARNING -eq 1 ] && dk_echo "\n${red}*** PAUSE_ON_WARNING ***${clr}" && dk_pause; true #OR PAUSE AND NOT NO_PAUSE)
	[ $HALT_ON_WARNING -eq 1 ]  && dk_echo "\n${red}*** HALT_ON_WARNING ***${clr}"  && dk_exit; true #OR HALT AND NOT NO_HALT)
}








DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_warning "test dk_warning message"
	dk_info "...next line..."

}