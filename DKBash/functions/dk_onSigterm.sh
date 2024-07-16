#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# dk_onSigterm()
#
#
dk_onSigterm() {
	dk_debugFunc
	
	dk_echo "received SIGTERM signal"
}
trap 'dk_onSigterm' SIGTERM




####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
DKTEST() { 
	echo "sending SIGTERM signal . . ."
	kill -TERM $$
}