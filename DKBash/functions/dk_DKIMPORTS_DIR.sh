#!/bin/bash
###### DK.sh #####################################################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


###############################################################################
# dk_DKIMPORTS_DIR()
#
#
dk_DKIMPORTS_DIR() {
	dk_debugFunc 0 1
	
	############ SET ############
	if [ -n "${1-}" ]; then  
		export DKIMPORTS_DIR="${1}" 

	############ GET ############
	elif [ ! -e "${DKIMPORTS_DIR-}" ]; then
		dk_call dk_validate DK3RDPARTY_DIR "dk_call dk_DK3RDPARTY_DIR" 
		export DKIMPORTS_DIR="${DK3RDPARTY_DIR}/_DKIMPORTS"
	fi
	
	builtin echo "${DKIMPORTS_DIR-}"
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_echo
	dk_call dk_echo "Test Getting DKIMPORTS_DIR . . ."
    dk_call dk_DKIMPORTS_DIR
    dk_call dk_printVar DKIMPORTS_DIR
	
	dk_call dk_echo
	dk_call dk_echo "Test Setting DKIMPORTS_DIR . . ."
	dk_call dk_DKIMPORTS_DIR "/C/DK/_DKIMPORTS"
	dk_call dk_printVar DKIMPORTS_DIR 
}
