#!/bin/sh
[ -z "${DKINIT}" ] && ( . "$(dirname $0)/DK.sh"; exit )


##################################################################################
# dk_onExit()
#
#
dk_onExit () {
	dk_debugFunc
	echo "dk_onExit"
	read -rp 'Press enter to continue...' key
	#dk_pause
}
trap 'dk_onExit' EXIT




####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
DKTEST() { 
	echo "calling exit . . ."
	#sleep 3
	exit
}