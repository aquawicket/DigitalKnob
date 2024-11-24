#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

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
		export DK3RDPARTY_DIR "${DKBRANCH_DIR}/3rdParty"  
		if [ ! -e "${DK3RDPARTY_DIR}" ]; then
			dk_call dk_makeDirectory "${DK3RDPARTY_DIR}" 
		fi  
	fi 
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_DK3RDPARTY_DIR
	dk_call dk_printVar DKBRANCH_DIR
}
