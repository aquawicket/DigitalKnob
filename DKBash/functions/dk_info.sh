#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


[ -z ${ENABLE_dk_info-} ] && export ENABLE_dk_info=1
[ -z ${TRACE_ON_INFO-} ]  && export TRACE_ON_INFO=0
[ -z ${LINE_ON_INFO-} ]   && export LINE_ON_INFO=0
[ -z ${PAUSE_ON_INFO-} ]  && export PAUSE_ON_INFO=0
[ -z ${HALT_ON_INFO-} ]   && export HALT_ON_INFO=0
[ -z ${INFO_TAG-} ]       && export INFO_TAG=""
##################################################################################
# dk_info(<message>)
#
#	Print a info message to the console
#
#	@msg	- The message to print
#
dk_info() {
	dk_debugFunc
	[ ${#} -ne 1 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	
	
	[ ${ENABLE_dk_info} -ne "1" ] && return
	msg="${1}"
	
	[ -z ${echo_fileline-} ] && export echo_fileline="$(__FILE__ 1):$(__LINE__ 1)   "
	dk_echo "${white-}${INFO_TAG}${msg}${clr-}"
	
	[ ${TRACE_ON_INFO} -eq 1 ] && dk_echo "\n${white-}*** TRACE_ON_INFO ***${clr-}" && dk_stacktrace; true #OR TRACE AND NOT NO_TRACE)
	[ ${LINE_ON_INFO} -eq 1 ]  && dk_echo "\n${white-}*** LINE_ON_INFO ***${clr-}"  && dk_showFileLine "${BASH_SOURCE[1]}" "${BASH_LINENO[0]}"; true #OR HALT AND NOT NO_HALT)
	[ ${PAUSE_ON_INFO} -eq 1 ] && dk_echo "\n${white-}*** PAUSE_ON_INFO ***${clr-}" && dk_pause; true #OR PAUSE AND NOT NO_PAUSE)
	[ ${HALT_ON_INFO} -eq 1 ]  && dk_echo "\n${white-}*** HALT_ON_INFO ***${clr-}"  && dk_exit; true #OR HALT AND NOT NO_HALT)
}




DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc
	
	dk_info "test message from dk_info"
}