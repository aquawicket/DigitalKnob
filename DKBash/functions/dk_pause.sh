#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_pause()
#
#	Pause execution and wait for keypress to continue
#
dk_pause() {
	dk_debugFunc 0

	
	#read -rp 'Press enter to continue...'; # key; echo ${key}
	dk_echo "Press enter to continue..."; 
	read -rp '';
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_pause
}
