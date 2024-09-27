#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"

##################################################################################
# dk_getUsername(<output>)
#
#
dk_getUsername() {
	dk_debugFunc 1

	if [ -n "${USER-}" ]; then
		DKUSERNAME=${USER}
	elif [ -n "${USERNAME-}" ]; then
		DKUSERNAME=${USERNAME}
	fi
	
	eval "${1}=${DKUSERNAME}"
	dk_call dk_printVar "${1}"
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_getUsername _username
	dk_call dk_echo "_username = ${_username}"
}
