#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_validateSudo()
#
#
dk_validateSudo() {
	dk_debugFunc 0

	
	if command -v "sudo" >/dev/null 2>&1; then
		dksudo="sudo"
	fi
	${dksudo-} echo
}


###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {

	dk_validateSudo
}