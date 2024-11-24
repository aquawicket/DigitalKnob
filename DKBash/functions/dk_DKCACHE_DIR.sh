#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

####################################################################
# dk_DKCACHE_DIR()
#
#
dk_DKCACHE_DIR() {
    dk_debugFunc 0 1

	############ SET ############
	if [ -n "${1-}" ]; then  
		export DKCACHE_DIR="${1}" 

	############ GET ############
	else
		dk_call dk_validate DKHOME_DIR "dk_DKHOME_DIR" 
		export DKCACHE_DIR="${DKHOME_DIR}/.dk"  
	fi 
	if [ ! -e "${DKCACHE_DIR}" ]; then
		dk_call dk_makeDirectory "${DKCACHE_DIR}" 
	fi
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
    dk_debugFunc 0 
   
	dk_call dk_echo
	dk_call dk_echo "Test Getting DKCACHE_DIR . . ."
	dk_call dk_DKCACHE_DIR
	dk_call dk_printVar DKCACHE_DIR
	
	dk_call dk_echo
	dk_call dk_echo "Test Setting DKCACHE_DIR . . ."
	dk_call dk_DKCACHE_DIR "/C/.dk"
	dk_call dk_printVar DKCACHE_DIR 
}
