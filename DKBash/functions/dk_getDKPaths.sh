#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


#####################################################################
# dk_getDKPaths()
#
#
dk_getDKPaths (){
	dk_debugFunc
	[ ${#} -ne 0 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	
	if [ -n "${USERPROFILE-}" ]; then
		dk_printVar USERPROFILE
		DIGITALKNOB_DIR="${USERPROFILE}\digitalknob"
		dk_replaceAll "${DIGITALKNOB_DIR}" "\\" "/" DIGITALKNOB_DIR
		dk_replaceAll "${DIGITALKNOB_DIR}" "C:" "/c" DIGITALKNOB_DIR
	elif [ -n "${HOME-}" ]; then
		dk_printVar HOME
		DIGITALKNOB_DIR="${HOME}/digitalknob"
	else
		dk_error "dk_getDKPaths(): unable to locate user root directory"
	fi
	dk_printVar DIGITALKNOB_DIR
	dk_makeDirectory "${DIGITALKNOB_DIR}"
	
	DKTOOLS_DIR="${DIGITALKNOB_DIR}/DKTools"
	dk_makeDirectory "${DKTOOLS_DIR}"
	dk_printVar DKTOOLS_DIR
	
	DKDOWNLOAD_DIR="${DIGITALKNOB_DIR}/download"
	dk_makeDirectory "${DKDOWNLOAD_DIR}"
	dk_printVar DKDOWNLOAD_DIR
}



DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_getDKPaths
}