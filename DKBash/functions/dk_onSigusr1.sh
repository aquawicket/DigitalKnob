#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# dk_onSigusr1()
#
#
dk_onSigusr1() {
	dk_debugFunc
	
	dk_echo "received SIGUSR1 signal"
}
trap 'dk_onSigusr1' SIGUSR1




####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
DKTEST() { 
	dk_debugFunc
	
	echo "sending SIGUSR1  signal . . ."
	kill -s USR1 $$
}