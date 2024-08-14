#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

[ -z ${PAUSE_ON_EXIT-} ] && PAUSE_ON_EXIT=1
##################################################################################
# dk_exit(exit_code)
#
#
dk_exit() {
	dk_debugFunc 0 1

	# TODO: when open with icon, we can use exec to keep the window open
	#[ $SHLVL -gt 1 ] && dk_call dk_echo "exec ${SHELL}"
	#[ $SHLVL -eq 1 ] && dk_call dk_pause
	
	[ -n "${1-}" ] && exit_code=${1} || exit_code=0  ## default exit code is 0
	#[ "${exit_code}" = "0" ] && trap '' EXIT
	trap '' EXIT
	
	dk_call dk_echo "dk_exit ${exit_code}"
	[ ${PAUSE_ON_EXIT} = 1 ] && dk_call dk_echo "*** PAUSE_ON_EXIT ***" && dk_call dk_pause
	builtin exit ${exit_code}
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	#Note: Only 'dk_exit 0' will turn the dk_onExit trap off
	
	#dk_call dk_exit
	#dk_call dk_exit 0
	dk_call dk_exit 123
}
