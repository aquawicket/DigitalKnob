#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

##################################################################################
# dk_onSigterm()
#
#
dk_onSigterm() {
	dk_debugFunc 0
	
	dk_echo "received SIGTERM signal"
}
trap 'dk_onSigterm' SIGTERM




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	echo "sending SIGTERM signal . . ."
	kill -TERM $$
}