if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_gitDiffSummary){ $dk_gitDiffSummary = 1 } else{ return }

################################################################################
# dk_gitDiffSummary()
#
#
function Global:dk_gitDiffSummary (){
	dk_debugFunc
	if($(__ARGC__) -ne 0){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
        
	dk_validate DKBRANCH_DIR "dk_validateBranch"
	cd "${DKBRANCH_DIR}" #-or dk_error "cd \${DKBRANCH_DIR} failed!"
    
	dk_validate GIT_EXE "dk_installGit"

    dk_call "${GIT_EXE}" --no-pager diff --compact-summary
}







function Global:DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dk_gitDiffSummary
}