#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

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
		export DKTOOLS_DIR "${DIGITALKNOB_DIR}/DKTools"  
		if [ ! -n "${DKTOOLS_DIR}" ]; then
			dk_call dk_makeDirectory "${DKTOOLS_DIR}" 
		fi  
	fi  
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
    dk_debugFunc 0 
   
	###### GET ######
	dk_call dk_DKTOOLS_DIR  
    dk_call dk_printVar DKTOOLS_DIR 
	
#	###### SET ######
#	dk_call dk_DKTOOLS_DIR "/C/Dummy/DKTools" 
#	dk_call dk_printVar DKTOOLS_DIR 
#	
#	###### GET ######
#	dk_call dk_DKTOOLS_DIR  
#   dk_call dk_printVar DKTOOLS_DIR 
#	
#	###### SET ######
#	dk_call dk_DKTOOLS_DIR "/C/dk2/DKTools" 
#	dk_call dk_printVar DKTOOLS_DIR 
}
