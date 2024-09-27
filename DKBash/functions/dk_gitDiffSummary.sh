#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"

################################################################################
# dk_gitDiffSummary()
#
#
dk_gitDiffSummary() {
	dk_debugFunc 0
  
	dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR"
    cd ${DKBRANCH_DIR}
    
	dk_call dk_validate GIT_EXE "dk_call dk_installGit"

    "${GIT_EXE}" --no-pager diff --compact-summary
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_gitDiffSummary
}
