#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

###############################################################################
# dk_DKAPPS_DIR()
#
#
dk_DKAPPS_DIR() {
	dk_debugFunc 0 1
	
	############ SET ############
	if [ -n "${1-}" ]; then  
		export DKAPPS_DIR="${1}" 

	############ GET ############
	else
		dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR" 
		export DKAPPS_DIR="${DKBRANCH_DIR}/DKApps"   
	fi
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_DKAPPS_DIR
	dk_call dk_printVar DKAPPS_DIR
}
