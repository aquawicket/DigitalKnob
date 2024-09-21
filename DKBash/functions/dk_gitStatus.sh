#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

################################################################################
# dk_gitStatus()
#
#
dk_gitStatus() {
	dk_debugFunc 0
  
	dk_call dk_validate GIT_EXE "dk_call dk_installGit"

    "${GIT_EXE}" status
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_gitStatus
}
