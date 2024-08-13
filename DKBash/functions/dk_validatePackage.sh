#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# dk_validatePackage(<command> <package>)
#
#
dk_validatePackage() {
	dk_debugFunc 2
	
	if ! dk_call dk_commandExists "${1}"; then
		dk_call dk_install "${2}"
	fi
}


###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_validatePackage
}
