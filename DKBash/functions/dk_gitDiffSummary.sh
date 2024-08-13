#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

################################################################################
# dk_gitDiffSummary()
#
#
dk_gitDiffSummary() {
	dk_debugFunc 0
  
	dk_call dk_validate DKBRANCH_DIR "dk_call dk_validateBranch"
    cd ${DKBRANCH_DIR}
    
	dk_call dk_validate GIT_EXE "dk_call dk_installGit"

    "${GIT_EXE}" --no-pager diff --compact-summary
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_gitDiffSummary
}
