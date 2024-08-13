#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# dk_exit(rtn_code)
#
#
dk_exit() {
	dk_debugFunc 1

	# TODO: when open with icon, we can use exec to keep the window open
	#[ $SHLVL -gt 1 ] && dk_call dk_echo "exec ${SHELL}" || dk_call dk_echo "exit ${*}"
	#[ $SHLVL -eq 1 ] && read -rp 'Press enter to exit...' key
	
	[ ${1-} -eq 0 ] && trap '' EXIT
	builtin exit ${1-}
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	# Only 'dk_exit 0' will turn the dk_onExit trap off
	dk_call dk_exit 0
}
