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
   
	###### GET ######
	dk_call dk_DKDESKTOP_DIR  
    dk_call dk_printVar DKDESKTOP_DIR 
}
