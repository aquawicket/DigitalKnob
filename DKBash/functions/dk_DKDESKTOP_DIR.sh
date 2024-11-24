#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

####################################################################
# dk_DKDESKTOP_DIR()
#
#
dk_DKDESKTOP_DIR() {
    dk_debugFunc 0 1

	############ SET ############
	if [ -n "${1-}" ]; then  
		export DKDESKTOP_DIR="${1}" 

	############ GET ############
	else
		dk_call dk_validate DKHOME_DIR "dk_DKHOME_DIR" 
		export DKDESKTOP_DIR="${DKHOME_DIR}/Desktop"  
	fi 
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
    dk_debugFunc 0 
   
	dk_call dk_echo
	dk_call dk_echo "Test Getting DKDESKTOP_DIR . . ."
	dk_call dk_DKDESKTOP_DIR
	dk_call dk_printVar DKDESKTOP_DIR
	
	dk_call dk_echo
	dk_call dk_echo "Test Setting DKDESKTOP_DIR . . ."
	dk_call dk_DKDESKTOP_DIR "/C/Desktop"
	dk_call dk_printVar DKDESKTOP_DIR 
}
