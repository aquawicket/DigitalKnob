#!/usr/bin/env sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

###############################################################################
# dk_DKAPPS_DIR()
#
#
dk_DKAPPS_DIR() {
	dk_debugFunc 0 1
	
	############ SET ############
	if [ -n "${1-}" ]; then  
		export DKCPP_APPS_DIR="${1}"
		return
	fi
	
	############ GET ############
	dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR" 
	export DKCPP_APPS_DIR="${DKBRANCH_DIR}/DKCpp/apps"   
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_echo
	dk_call dk_echo "Test Getting DKCPP_APPS_DIR . . ."
	dk_call dk_DKAPPS_DIR
	dk_call dk_printVar DKCPP_APPS_DIR
	
	dk_call dk_echo
	dk_call dk_echo "Test Setting DKCPP_APPS_DIR . . ."
	dk_call dk_DKAPPS_DIR "/c/DK/apps"
	dk_call dk_printVar DKCPP_APPS_DIR 
}
