#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

##################################################################################
# dk_getFullPath(path, output)
#
#
dk_getFullPath() {
	dk_debugFunc 2

	dk_call dk_realpath "${1}" _realpath_
	eval "${2}=${_realpath_}"
	dk_call dk_printVar "${2}"
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_getFullPath "bash" fullPath
	dk_call dk_echo "fullPath = ${fullPath}"
}
