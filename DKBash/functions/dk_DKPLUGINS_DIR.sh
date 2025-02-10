#!/usr/bin/env sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

###############################################################################
# dk_DKPLUGINS_DIR()
#
#
dk_DKPLUGINS_DIR() {
	dk_debugFunc 0 1
	
	############ SET ############
	if [ -n "${1-}" ]; then  
		export DKPLUGINS_DIR="${1}" 

	############ GET ############
	else
		dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR" 
		export DKPLUGINS_DIR="${DKBRANCH_DIR}/DKCpp/DKPlugins"   
	fi
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_echo
	dk_call dk_echo "Test Getting DKPLUGINS_DIR . . ."
    dk_call dk_DKPLUGINS_DIR
    dk_call dk_printVar DKPLUGINS_DIR
	
	dk_call dk_echo
	dk_call dk_echo "Test Setting DKPLUGINS_DIR . . ."
	dk_call dk_DKPLUGINS_DIR "/C/DK/DKPlugins"
	dk_call dk_printVar DKPLUGINS_DIR 
}
