#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

#####################################################################
# dk_DIGITALKNOB_DIR()
#
#
dk_DIGITALKNOB_DIR() {
	dk_debugFunc 0 1

	### DIGITALKNOB_DIR ###
	[ -n "${DIGITALKNOB-}" ] || DIGITALKNOB="digitalknob"
	
	############ SET ############
	if [ -n "${1-}" ]; then  
		export DIGITALKNOB_DIR="${1}" 

	############ GET ############
	else
		dk_call dk_validate DKHOME_DIR "dk_DKHOME_DIR" 
		export DIGITALKNOB_DIR="${DKHOME_DIR}/${DIGITALKNOB}"  
	fi 
	if [ ! -e "${DIGITALKNOB_DIR}" ]; then
		dk_call dk_mkdir "${DIGITALKNOB_DIR}" 
	fi
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
	dk_debugFunc 0
	
	dk_call dk_echo
	dk_call dk_echo "Test Getting DIGITALKNOB_DIR . . ."
	dk_call dk_DIGITALKNOB_DIR
	dk_call dk_printVar DIGITALKNOB_DIR
	
	dk_call dk_echo
	dk_call dk_echo "Test Setting DIGITALKNOB_DIR . . ."
	dk_call dk_DIGITALKNOB_DIR "/C/DK"
	dk_call dk_printVar DIGITALKNOB_DIR 
}
