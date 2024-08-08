#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

[ -z ${KEY_WAIT_ON_EXIT-} ]  && dk_export KEY_WAIT_ON_EXIT 1
[ -z ${STAY_OPEN_ON_EXIT-} ] && dk_export STAY_OPEN_ON_EXIT 0
##################################################################################
# dk_onExit()
#
#
dk_onExit() {
	dk_debugFunc 0

#	[ ${KEY_WAIT_ON_EXIT} -eq 1 ] && [ $SHLVL -eq 1 ] && dk_pause
#	[ ${STAY_OPEN_ON_EXIT} -eq 1 ] && [ $SHLVL -eq 1 ] && exec ${SHELL}
	[ ${KEY_WAIT_ON_EXIT} -eq 1 ] && dk_pause
	[ ${STAY_OPEN_ON_EXIT} -eq 1 ] && exec ${SHELL}
}
trap 'dk_onExit' EXIT




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
	dk_echo "calling exit . . ."
	dk_exit

	# Only 'dk_exit 0' will turn the trap off
	# dk_exit 0
}