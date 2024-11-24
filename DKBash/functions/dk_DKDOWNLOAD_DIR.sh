#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

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
		dk_call dk_validate DIGITALKNOB_DIR "dk_DIGITALKNOB_DIR" 
		export DKDOWNLOAD_DIR "${DIGITALKNOB_DIR}/download"  
		if [ ! -n "${DKDOWNLOAD_DIR}" ]; then
			dk_call dk_makeDirectory "${DKDOWNLOAD_DIR}" 
		fi  
	fi  
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
    dk_debugFunc 0
   
	dk_call dk_DKDOWNLOAD_DIR
    dk_call dk_printVar DKDOWNLOAD_DIR
}
