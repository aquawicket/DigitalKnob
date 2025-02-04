#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

###############################################################################
# dk_DKAPPS_DIR()
#
#
dk_DKAPPS_DIR() {
	dk_debugFunc 0 1
	
	############ SET ############
	if [ -n "${1-}" ]; then  
		export DKAPPS_DIR="${1}"
		return
	fi
	
	############ GET ############
	dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR" 
	export DKAPPS_DIR="${DKBRANCH_DIR}/DKApps"   
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_echo
	dk_call dk_echo "Test Getting DKAPPS_DIR . . ."
	dk_call dk_DKAPPS_DIR
	dk_call dk_printVar DKAPPS_DIR
	
	dk_call dk_echo
	dk_call dk_echo "Test Setting DKAPPS_DIR . . ."
	dk_call dk_DKAPPS_DIR "/C/DK/DKApps"
	dk_call dk_printVar DKAPPS_DIR 
}
