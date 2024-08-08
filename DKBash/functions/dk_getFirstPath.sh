#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_getFirstPath(result)
#
#
dk_getFirstPath() {
	dk_debugFunc 1

	
	eval "${1}=${PATH%%:*}"
	dk_printVar ${1}
}



DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc 0
	
	dk_getFirstPath firstPath
	dk_echo "firstPath = ${firstPath}"
}
