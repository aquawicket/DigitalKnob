#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_getFullPath(path, output)
#
#
dk_getFullPath() {
	dk_debugFunc 2

	
	dk_realpath "${1}" _realpath_
	eval "${2}=${_realpath_}"
	dk_printVar "${2}"
}



DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc 0
	
	dk_getFullPath "bash" fullPath
	dk_echo "fullPath = ${fullPath}"
}
