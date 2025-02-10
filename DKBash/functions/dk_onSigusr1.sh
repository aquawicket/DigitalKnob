#!/usr/bin/env sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

##################################################################################
# dk_onSigusr1()
#
#
dk_onSigusr1() {
	dk_debugFunc 0
	
	dk_echo "received SIGUSR1 signal"
}
trap 'dk_onSigusr1' SIGUSR1




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
	dk_debugFunc 0
	
	echo "sending SIGUSR1  signal . . ."
	kill -s USR1 $$
}