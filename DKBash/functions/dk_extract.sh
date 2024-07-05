#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_extract(<file_path> <destination>)
#
#
dk_extract (){
	dk_debugFunc
	[ ${#} -ne 2 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	
	#src="${1}"
	#dest="$2"
	
	if ! dk_pathExists "${2}"; then
		dk_makeDirectory "${2}"
	fi
	
	dk_getExtension "${1}" extension
	
	if [ "${extension}" = "zip" ]; then
		if ! dk_commandExists unzip; then
			dk_install unzip
		fi
		echo "unzip '${1}' -d '${2}'"
		unzip "${1}" -d "${2}"
	else
		echo "tar -xf '${1}' -C '${2}'"
		tar -xf "${1}" -C "${2}"
	fi
}



DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_validate DKDOWNLOAD_DIR "dk_getDKPaths"
	dk_extract "${DKDOWNLOAD_DIR}/cmake-3.29.5-windows-x86_64.zip" "${DKDOWNLOAD_DIR}"
}