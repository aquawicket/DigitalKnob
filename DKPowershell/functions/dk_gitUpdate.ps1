if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_gitUpdate){ $dk_gitUpdate = 1 } else{ return }

##################################################################################
# dk_gitUpdate(url, branch, NO_CONFIRM)
#
#
function Global:dk_gitUpdate($url, $branch) {
	dk_debugFunc 2 3

	if($args[0]){ $url="$args[0]" }    else { $url="https://github.com/aquawicket/DigitalKnob.git" }
	if($args[1]){ $branch="$args[1]" } else { $branch="Development" }
	
	if(!($args[2] -eq "NO_CONFIRM")){
		dk_call dk_info "Git Update? Any local changes will be lost."
		if(!(dk_call dk_confirm)){ return 0 }
	}
	
	dk_call dk_validate GIT_EXE "dk_call dk_installGit"
	if(!(dk_call dk_pathExists "${DKBRANCH_DIR}/.git")){
		dk_call dk_printVar DKBRANCH_DIR
		dk_call "${GIT_EXE}" clone "${url}" "${DKBRANCH_DIR}"
	}
	dk_call cd "${DKBRANCH_DIR}" #-or dk_call dk_error "cd $${DKBRANCH_DIR} failed!"
	dk_call "${GIT_EXE}" pull --all
	dk_call "${GIT_EXE}" checkout -- .
	dk_call "${GIT_EXE}" checkout "${branch}"
	if( $? -eq "0" ){
		dk_call dk_info "${branch} branch selected"
	} else {
		dk_call dk_info "Remote has no ${branch} branch. Creating..."
		dk_call "${GIT_EXE}" checkout -b "${branch}" main
		dk_call "${GIT_EXE}" push --set-upstream origin "${branch}"
	}
	#dk_call chmod +x "${DKBRANCH_DIR}"/build
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_gitUpdate https://github.com/aquawicket/DigitalKnob.git Development
}
