#!/usr/bin/env sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

###############################################################################
# dk_DK3RDPARTY_DIR()
#
#
dk_DK3RDPARTY_DIR() {
	dk_debugFunc 0 1
	
	############ SET ############
	if [ -n "${1-}" ]; then  
		export DK3RDPARTY_DIR="${1}" 

	############ GET ############
	else
		dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR" 
		export DK3RDPARTY_DIR="${DKBRANCH_DIR}/3rdParty"   
	fi
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_echo
	dk_call dk_echo "Test Getting DK3RDPARTY_DIR . . ."
	dk_call dk_DK3RDPARTY_DIR
	dk_call dk_printVar DK3RDPARTY_DIR
	
	dk_call dk_echo
	dk_call dk_echo "Test Setting DK3RDPARTY_DIR . . ."
	dk_call dk_DK3RDPARTY_DIR "/C/DK/3rdParty"
	dk_call dk_printVar DK3RDPARTY_DIR 
}
