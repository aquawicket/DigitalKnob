if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$dk_gitUpdate){ $dk_gitUpdate = 1 } else{ return }


##################################################################################
# dk_gitUpdate(<NO_CONFIRM:optional>)
#
#
function Global:dk_gitUpdate () {
	dk_debugFunc
	if($(__ARGC__) -ne 0){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }

	if(!($Args[0] -eq "NO_CONFIRM")){
		dk_info "Git Update? Any local changes will be lost."
		if(!(dk_confirm)){ return 0 }
	}
	
	dk_validate GIT_EXE "dk_validateGit"
	if(dk_filexists "${DKBRANCH_DIR}/.git"){
		dk_printVar DKBRANCH_DIR
		dk_call "${GIT_EXE}" clone https://github.com/aquawicket/DigitalKnob.git "${DKBRANCH_DIR}"
	}
	dk_call cd "${DKBRANCH_DIR}" #|| dk_error "cd $${DKBRANCH_DIR} failed!"
	dk_call "${GIT_EXE}" pull --all
	dk_call "${GIT_EXE}" checkout -- .
	dk_call "${GIT_EXE}" checkout "${DKBRANCH}"
	if( $? -eq "0" ){
		dk_info "${DKBRANCH} branch selected"
	} else {
		dk_info "Remote has no ${DKBRANCH} branch. Creating..."
		dk_call "${GIT_EXE}" checkout -b "${DKBRANCH}" main
		dk_call "${GIT_EXE}" push --set-upstream origin "${DKBRANCH}"
	}
	#dk_call chmod +x "${DKBRANCH_DIR}"/build
}



function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_gitUpdate
}