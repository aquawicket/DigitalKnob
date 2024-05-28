#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_onExit()
#
#
dk_onExit () {
	#dk_debugFunc

	[ $SHLVL -eq 1 ] && read -rp 'dk_onExit(): Press enter to exit...' key
}
trap 'dk_onExit' EXIT




####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
DKTEST() { 
	echo "calling exit . . ."
	#sleep 3
	exit
}