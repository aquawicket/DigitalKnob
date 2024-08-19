#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

#####################################################################
# dk_getDKPaths()
#
#
dk_getDKPaths() {
	dk_debugFunc 0

	if [ -n "${USERPROFILE-}" ]; then
		dk_call dk_printVar USERPROFILE
		DIGITALKNOB_DIR="${USERPROFILE}\digitalknob"
		dk_call dk_commandExists "cygpath" && DIGITALKNOB_DIR=$(cygpath -u "${DIGITALKNOB_DIR}")
		dk_call dk_replaceAll "${DIGITALKNOB_DIR}" "\\" "/" DIGITALKNOB_DIR
	elif [ -n "${HOME-}" ]; then
		dk_call dk_printVar HOME
		DIGITALKNOB_DIR="${HOME}/digitalknob"
	else
		dk_call dk_error "dk_getDKPaths(): unable to locate user root directory"
	fi
	dk_call dk_printVar DIGITALKNOB_DIR
	dk_call dk_makeDirectory "${DIGITALKNOB_DIR}"
	
	DKTOOLS_DIR="${DIGITALKNOB_DIR}/DKTools"
	dk_call dk_makeDirectory "${DKTOOLS_DIR}"
	dk_call dk_printVar DKTOOLS_DIR
	
	DKDOWNLOAD_DIR="${DIGITALKNOB_DIR}/download"
	dk_call dk_makeDirectory "${DKDOWNLOAD_DIR}"
	dk_call dk_printVar DKDOWNLOAD_DIR
	
	DKTEMP_DIR="${DIGITALKNOB_DIR}/temt"
	dk_call dk_makeDirectory "${DKTEMP_DIR}"
	dk_call dk_printVar DKTEMP_DIR
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
	dk_debugFunc 0
	
	dk_call dk_getDKPaths
}
