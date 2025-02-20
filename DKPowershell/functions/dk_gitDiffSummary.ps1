if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_gitDiffSummary){ $dk_gitDiffSummary = 1 } else{ return } #include guard

################################################################################
# dk_gitDiffSummary()
#
#
function Global:dk_gitDiffSummary() {
	dk_debugFunc 0

        
	dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR"
	cd "${DKBRANCH_DIR}" #-or dk_call dk_error "cd \${DKBRANCH_DIR} failed!"
    
	dk_call dk_validate GIT_EXE "dk_call dk_installGit"

    dk_call "${GIT_EXE}" --no-pager diff --compact-summary
}














###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_gitDiffSummary
}
