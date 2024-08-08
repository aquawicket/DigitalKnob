#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_exit(rtn_code)
#
#
dk_exit() {
	dk_debugFunc
	[ ${#} -ne 1 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	
	# TODO: when open with icon, we can use exec to keep the window open
	#[ $SHLVL -gt 1 ] && dk_echo "exec ${SHELL}" || dk_echo "exit ${*}"
	#[ $SHLVL -eq 1 ] && read -rp 'Press enter to exit...' key
	
	[ ${1} -eq 0 ] && trap '' EXIT
	builtin exit ${1}
}



DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc
	
	# Only 'dk_exit 0' will turn the dk_onExit trap off
	dk_exit 0
}
