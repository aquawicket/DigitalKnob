#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# dk_extract(file_path, destination)
#
#
dk_extract() {
	dk_debugFunc 2

	#local src="${1}"
	#local dest="${2}"
	
	dk_call dk_pathExists "${2}" || dk_call dk_makeDirectory "${2}"
	dk_call dk_getExtension "${1}" extension
	
	if [ "${extension}" = "zip" ]; then
		dk_call dk_commandExists unzip || dk_call dk_installPackage unzip
		unzip "${1}" -d "${2}"
	else
		dk_call dk_commandExists tar || dk_call dk_installPackage tar
		tar -xf "${1}" -C "${2}"
	fi
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_validate DKDOWNLOAD_DIR "dk_call dk_getDKPaths"
	dk_call dk_extract "${DKDOWNLOAD_DIR}/cmake-3.29.5-windows-x86_64.zip" "${DKDOWNLOAD_DIR}"
}
