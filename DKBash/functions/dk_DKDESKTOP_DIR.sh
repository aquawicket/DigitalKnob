#!/bin/sh
###### DK.sh #####################################################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


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
	elif [ ! -e "${DKDESKTOP_DIR-}" ]; then
		dk_call dk_validate DKHOME_DIR "dk_call DKHOME_DIR" 
		export DKDESKTOP_DIR="${DKHOME_DIR}/Desktop"  
	fi
	
	builtin echo "${DKDESKTOP_DIR-}"
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
