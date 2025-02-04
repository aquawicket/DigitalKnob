#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

####################################################################
# dk_DKTOOLS_DIR()
#
#
dk_DKTOOLS_DIR() {
    dk_debugFunc 0 1

	############ SET ############
	if [ -n "${1-}" ]; then  
		export DKTOOLS_DIR="${1}" 

	############ GET ############
	else
		dk_call dk_validate DIGITALKNOB_DIR "dk_DIGITALKNOB_DIR" 
		export DKTOOLS_DIR="${DIGITALKNOB_DIR}/DKTools"  
	fi
	
	if [ ! -e "${DKTOOLS_DIR}" ]; then
		dk_call dk_makeDirectory "${DKTOOLS_DIR}" 
	fi  
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
    dk_debugFunc 0 
	
	dk_call dk_echo
	dk_call dk_echo "Test Getting DKTOOLS_DIR . . ."
    dk_call dk_DKTOOLS_DIR
    dk_call dk_printVar DKTOOLS_DIR
	
	dk_call dk_echo
	dk_call dk_echo "Test Setting DKTOOLS_DIR . . ."
	dk_call dk_DKTOOLS_DIR "/C/DK/DKTools"
	dk_call dk_printVar DKTOOLS_DIR 
}
