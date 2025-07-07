#!/bin/bash
###### DK.sh #####################################################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


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
		[ -n "${DKTOOLS-}" ] 		|| export DKTOOLS="DKTools"
		[ -n "${DKTOOLS_DIR-}" ] 	|| export DKTOOLS_DIR="$(dk_call dk_DIGITALKNOB_DIR)/DKTools"  
	fi
	
	########## FINALIZE ############
	if [ ! -e "${DKTOOLS_DIR}" ]; then
		dk_call dk_mkdir "${DKTOOLS_DIR}" 
	fi
	
	builtin echo "${DKTOOLS_DIR-}"
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
    dk_debugFunc 0 
	
	# Using command substitution
	dk_call dk_echo;
	dk_call dk_echo "Test Getting DKTOOLS_DIR . . .";
    dk_call dk_echo "DKTOOLS_DIR = '$(dk_call dk_DKTOOLS_DIR)'";
	
	dk_call dk_echo;
	dk_call dk_echo "Test Setting DKTOOLS_DIR . . .";
	dk_call dk_echo "DKTOOLS_DIR = '$(dk_call dk_DKTOOLS_DIR '/c/Digital Knob/DKTools')'";
	
	# Using global variable
	dk_call dk_DKTOOLS_DIR
	dk_call dk_echo "DKTOOLS_DIR = '${DKTOOLS_DIR}'";
	
	dk_call dk_DKTOOLS_DIR "/c/Digital Knob/DKTools"
	dk_call dk_echo "DKTOOLS_DIR = '${DKTOOLS_DIR}'";
}
