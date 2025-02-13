#!/usr/bin/env sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

##################################################################################
# dk_timeout(seconds)
#
dk_timeout() {
	dk_debugFunc 0 1
	
    [ -n "${1-}" ] && seconds="${1}" || seconds="10"
	dk_call dk_assertVar seconds
	
	echo ""
	read -t ${seconds} -n 1 -s -r -p "waiting ${seconds} seconds. Press any key to continue . . ." && return 0 || return 0
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_timeout 1
	dk_call dk_timeout 2
	dk_call dk_timeout 3
	dk_call dk_timeout 4
	dk_call dk_timeout 5
	dk_call dk_timeout
}
