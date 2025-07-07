#!/bin/sh
###### DK.sh #####################################################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


#####################################################################
# dk_DIGITALKNOB_DIR()
#
#
dk_DIGITALKNOB_DIR() {
	dk_debugFunc 0 1

	############ SET ############
	if [ -n "${1-}" ]; then  
		export DIGITALKNOB_DIR="${1}" 

	############ GET ############
	else
		[ -n "${DIGITALKNOB-}" ] || export DIGITALKNOB="DigitalKnob"
		[ -n "${DIGITALKNOB_DIR-}" ] || export DIGITALKNOB_DIR="$(dk_call dk_DKHOME_DIR)/${DIGITALKNOB}"  
	fi 
	
	########## FINALIZE ############
	if [ ! -e "${DIGITALKNOB_DIR}" ]; then
		dk_call dk_mkdir "${DIGITALKNOB_DIR}" 
	fi
	
	builtin echo "${DIGITALKNOB_DIR}"
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
	dk_debugFunc 0
	
	dk_call dk_echo;
	dk_call dk_echo "Test Getting DIGITALKNOB_DIR . . .";
    dk_call dk_echo "DIGITALKNOB_DIR = '$(dk_call dk_DIGITALKNOB_DIR)'";
	
	dk_call dk_echo;
	dk_call dk_echo "Test Setting DIGITALKNOB_DIR . . .";
	dk_call dk_echo "DIGITALKNOB_DIR = '$(dk_call dk_DIGITALKNOB_DIR '/c/Digital Knob')'";
}
