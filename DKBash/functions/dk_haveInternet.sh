#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

################################################################################
# dk_haveInternet(path)
#
dk_haveInternet() {
    dk_debugFunc 0
	
	ping -n 1 8.8.8.8 >/dev/null && return $(true)
	return $(false)
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
	dk_debugFunc 0
	
	dk_call dk_haveInternet && echo "Internet Connected" || echo "Internet Disconnected"
}
