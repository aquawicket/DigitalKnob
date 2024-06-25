#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

################################################################################
# dk_gitDiffSummary()
#
#
dk_gitDiffSummary (){
	dk_debugFunc
	[ $# -ne 0 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
        
	dk_validate DKBRANCH_DIR "dk_validateBranch"
    cd ${DKBRANCH_DIR}
    
	dk_validate GIT_EXE "dk_installGit"

    "${GIT_EXE}" --no-pager diff --compact-summary
}







DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dk_gitDiffSummary
}