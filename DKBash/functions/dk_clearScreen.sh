#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# dk_clearScreen()
#
#
dk_clearScreen() {
	dk_debugFunc 0

	
	clear
}



DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc
	
	dk_clearScreen
}