#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_extract(file_path, destination)
#
#
dk_extract() {
	dk_debugFunc
	[ ${#} -ne 2 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	
	#src="${1}"
	#dest="${2}"
	
	dk_pathExists "${2}" || dk_makeDirectory "${2}"
	dk_getExtension "${1}" extension
	
	if [ "${extension}" = "zip" ]; then
		dk_commandExists unzip || dk_install unzip
		unzip "${1}" -d "${2}"
	else
		dk_commandExists tar || dk_install tar
		tar -xf "${1}" -C "${2}"
	fi
}



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dk_validate DKDOWNLOAD_DIR "dk_getDKPaths"
	dk_extract "${DKDOWNLOAD_DIR}/cmake-3.29.5-windows-x86_64.zip" "${DKDOWNLOAD_DIR}"
}