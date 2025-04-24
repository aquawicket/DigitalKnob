<<<<<<< HEAD
#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"
=======
#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"
>>>>>>> Development

#####################################################################
# dk_DIGITALKNOB_DIR()
#
#
dk_DIGITALKNOB_DIR() {
<<<<<<< HEAD
	dk_debugFunc 0

	#[ -n "${DIGITALKNOB_DIR-}" ] && return 0
	
	dk_call dk_validate DKHOME_DIR  "dk_call dk_DKHOME_DIR"
	
	### DIGITALKNOB_DIR ###
	[ -n "${DIGITALKNOB-}" ] || DIGITALKNOB="digitalknob"
	export DIGITALKNOB_DIR="${DKHOME_DIR}/${DIGITALKNOB}"
	dk_call dk_makeDirectory "${DIGITALKNOB_DIR}"
	#dk_call dk_printVar DIGITALKNOB_DIR
	
	export DKTOOLS_DIR="${DIGITALKNOB_DIR}/DKTools"
	dk_call dk_makeDirectory "${DKTOOLS_DIR}"
	#dk_call dk_printVar DKTOOLS_DIR
	
	export DKDOWNLOAD_DIR="${DIGITALKNOB_DIR}/download"
	dk_call dk_makeDirectory "${DKDOWNLOAD_DIR}"
	#dk_call dk_printVar DKDOWNLOAD_DIR
	
#	[ -e "${DKTEMP_DIR}" ] ||     DKTEMP_DIR="${TMP-}"
#   [ -e "${DKTEMP_DIR}" ] ||     DKTEMP_DIR="${TMPDIR-}"
#   [ -e "${DKTEMP_DIR}" ] ||     DKTEMP_DIR="${TMP_DIR-}"
#	[ -e "${DKTEMP_DIR}" ] ||     DKTEMP_DIR="${DIGITALKNOB_DIR}/.dk"
#	[ -e "${DKTEMP_DIR}" ] &&     DKTEMP_DIR="${DKTEMP_DIR}/.dk"
#   [ -e "${DKTEMP_DIR}" ] ||     mkdir "${DKTEMP_DIR}"
#   [ -e "${DKTEMP_DIR}" ] ||     echo "ERROR: DKTEMP_DIR:${DKTEMP_DIR} does not exist"
#   [ -e "${DKTEMP_DIR}" ] &&     cp "${DKSCRIPT_PATH}" "${DKTEMP_DIR}" 1>nul 2>nul
#	dk_call dk_makeDirectory "${DKTEMP_DIR}"
#	dk_call dk_printVar DKTEMP_DIR
=======
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
>>>>>>> Development
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
	dk_debugFunc 0
	
<<<<<<< HEAD
	dk_call dk_DIGITALKNOB_DIR
	
	dk_call dk_printVar DIGITALKNOB_DIR
	dk_call dk_printVar DKTOOLS_DIR
	dk_call dk_printVar DKDOWNLOAD_DIR
=======
	dk_call dk_echo
	dk_call dk_echo "Test Getting DIGITALKNOB_DIR . . ."
	dk_call dk_DIGITALKNOB_DIR
	dk_call dk_printVar DIGITALKNOB_DIR
	
	dk_call dk_echo
	dk_call dk_echo "Test Setting DIGITALKNOB_DIR . . ."
	dk_call dk_DIGITALKNOB_DIR "/C/DK"
	dk_call dk_printVar DIGITALKNOB_DIR 
>>>>>>> Development
}
