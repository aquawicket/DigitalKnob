#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"

####################################################################
# dk_DKHOME_DIR()
#
#
dk_DKHOME_DIR() {
    dk_debugFunc 0

    #[ -n "${DKHOME_DIR}" ] && return 0
    
	### DKHOME_DIR ###
	if dk_call dk_defined WSLENV; then
		#HOMEDRIVE="$(cmd.exe /c echo %HOMEDRIVE%)"   # TODO: extract drive letter and convert to /mnt/L
		HOMEDRIVE="/mnt/c"
		HOMEPATH="$(cmd.exe /c echo %HOMEPATH%)"
		dk_call dk_replaceAll "${HOMEPATH}" "\\" "/" HOMEPATH
		DKHOME_DIR="${HOMEDRIVE}${HOMEPATH}"
	elif [ -n "${USERPROFILE-}" ]; then
		DKHOME_DIR="${USERPROFILE}"
		dk_call dk_commandExists "cygpath" && DKHOME_DIR=$(cygpath -u "${DKHOME_DIR}")
		dk_call dk_replaceAll "${DKHOME_DIR}" "\\" "/" DKHOME_DIR
	elif [ -n "${HOME-}" ]; then
		DKHOME_DIR="${HOME}"
	else
		dk_call dk_error "dk_DKHOME_DIR(): unable to locate HOME directory"
	fi
	[ -e "${DKHOME_DIR}" ]     || dk_call dk_fatal "DKHOME_DIR not found"
	#dk_call dk_printVar DKHOME_DIR
	
	### DKCACHE_DIR ###
	DKCACHE_DIR="${DKHOME_DIR}/.dk"
	[ -e "${DKCACHE_DIR}" ]    || dk_call dk_makeDirectory "${DKCACHE_DIR}"
	#dk_call dk_printVar DKCACHE_DIR
	
	### DKDESKTOP_DIR ###
	DKDESKTOP_DIR="${DKHOME_DIR}/Desktop"
    [ -e "${DKDESKTOP_DIR}" ]  || dk_call dk_fatal "DKDESKTOP_DIR:${DKDESKTOP_DIR} does not exist"
	#dk_call dk_printVar DKDESKTOP_DIR
	
	### DKTEMP_DIR ###
#	[ -e "${DKTEMP_DIR}" ] || dk_call dk_set DKTEMP_DIR "${TMP}"
#	[ -e "${DKTEMP_DIR}" ] || dk_call dk_set DKTEMP_DIR "${TMPDIR}"
#	[ -e "${DKTEMP_DIR}" ] || dk_call dk_set DKTEMP_DIR "${TMP_DIR%}"
#	[ -e "${DKTEMP_DIR}" ] || dk_call dk_validate DIGITALKNOB_DIR "dk_call dk_DIGITALKNOB_DIR" && dk_call dk_set DKTEMP_DIR "${DIGITALKNOB_DIR}"
#	[ -e "${DKTEMP_DIR}" ] || dk_call dk_fatal "unable to set .dk directory"
#	DKTEMP_DIR="${DKTEMP_DIR}/.dk"
#	[ -e "${DKTEMP_DIR}" ] ||  dk_makeDirectory "${DKTEMP_DIR}"

#${DKDEBUG}
	#dk_call dk_printVar DKHOME_DIR
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
    dk_debugFunc 0
 
    dk_call dk_DKHOME_DIR
	
    dk_call dk_printVar DKHOME_DIR
	dk_call dk_printVar DKCACHE_DIR
	dk_call dk_printVar DKDESKTOP_DIR
}
