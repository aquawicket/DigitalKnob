#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

[ -z ${KEY_WAIT_ON_EXIT-} ]  && export KEY_WAIT_ON_EXIT=1
[ -z ${STAY_OPEN_ON_EXIT-} ]  && export STAY_OPEN_ON_EXIT=0
##################################################################################
# dk_onExit()
#
#
dk_onExit () {
	dk_debugFunc

#	[ ${KEY_WAIT_ON_EXIT} -eq 1 ] && [ $SHLVL -eq 1 ] && read -rp 'dk_onExit(): Press enter to exit...' key
#	[ ${STAY_OPEN_ON_EXIT} -eq 1 ] && [ $SHLVL -eq 1 ] && exec $SHELL
	[ ${KEY_WAIT_ON_EXIT} -eq 1 ] && read -rp 'dk_onExit(): Press enter to exit...' key
	[ ${STAY_OPEN_ON_EXIT} -eq 1 ] && exec $SHELL
}
trap 'dk_onExit' EXIT




####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
DKTEST() { 
	echo "calling exit . . ."
	exit
}