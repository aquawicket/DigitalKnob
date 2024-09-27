#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"

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
