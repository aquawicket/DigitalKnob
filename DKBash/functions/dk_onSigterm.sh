#!/bin/sh
[ -z "${DKINIT}" ] && ( . "$(dirname $0)/DK.sh"; exit )


##################################################################################
# dk_onSigterm()
#
#
dk_onSigterm () {
	dk_debugFunc
	echo "dk_onSigterm"
	read -rp 'Press enter to continue...' key
}
trap 'dk_onSigterm' SIGTERM




####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
DKTEST() { 
	echo "sending SIGTERM signal . . ."
	sleep 3
	kill -SIGTERM $$
	read -rp 'Press enter to continue...' key
}