#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_installGit()
#
#
dk_installGit() {
	dk_debugFunc 0

	
	if ! dk_commandExists git; then
		dk_install git
	fi
	
	GIT_EXE=$(command -v git)
	[ -e "${GIT_EXE}" ] || dk_error "GIT_EXE is invalid"
	
	dk_printVar GIT_EXE
}



DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######

	dk_installGit
}