#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

####################################################################
# dk_DKDOWNLOAD_DIR()
#
#
dk_DKDOWNLOAD_DIR() {
    dk_debugFunc 0 1
            
	############ SET ############
	if [ -n "${1-}" ]; then  
		export DKDOWNLOAD_DIR="${1}" 

	############ GET ############
	else
		dk_call dk_validate DIGITALKNOB_DIR "dk_call dk_DIGITALKNOB_DIR" 
		export DKDOWNLOAD_DIR="${DIGITALKNOB_DIR}/download"   
	fi 

	if [ ! -e "${DKDOWNLOAD_DIR}" ]; then
		dk_call dk_mkdir "${DKDOWNLOAD_DIR}" 
	fi 
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
    dk_debugFunc 0
   
	dk_call dk_echo
	dk_call dk_echo "Test Getting DKDOWNLOAD_DIR . . ."
	dk_call dk_DKDOWNLOAD_DIR
	dk_call dk_printVar DKDOWNLOAD_DIR
	
	dk_call dk_echo
	dk_call dk_echo "Test Setting DKDOWNLOAD_DIR . . ."
	dk_call dk_DKDOWNLOAD_DIR "/C/DK/download"
	dk_call dk_printVar DKDOWNLOAD_DIR 
}
