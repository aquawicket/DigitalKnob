if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_gitCommit){ $dk_gitCommit = 1 } else{ return }

##################################################################################
# dk_gitCommit()
#
#
function Global:dk_gitCommit() {	
	dk_debugFunc
	if($(__ARGC__) -ne 0){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	dk_gitDiffSummary
	
	dk_info "Please enter some details about this commit, Then press ENTER."
	$message = Read-Host
	
	dk_validate DKBRANCH_DIR "dk_validateBranch"
	cd "${DKBRANCH_DIR}" #-or dk_error "cd \${DKBRANCH_DIR} failed!"
	
	dk_validate GIT_EXE "dk_installGit"
	
	if(!($STORE = $(dk_call ${GIT_EXE} config credential.helper))){
		dk_errorStatus
	}
	if(!${STORE}){
		dk_call ${GIT_EXE} config --global credential.helper store
		dk_echo
		dk_info "git credential.helper is now set to store"
		dk_echo
	}
	
	if(!($USER_EMAIL = $(dk_call ${GIT_EXE} config --global user.email))){
		dk_errorStatus
	}
	if(!${USER_EMAIL}){
		dk_echo
		dk_info "please enter an email address"
		$input = Read-Host
		dk_call ${GIT_EXE} config --global user.email "${input}"
		dk_echo
		dk_info "git user.email '${input}' saved"
		dk_echo
	}
	if(!($USER_NAME = $(dk_call ${GIT_EXE} config --global user.name))){
		dk_errorStatus
	}
	if(!${USER_NAME}){
		dk_echo
		dk_info "please enter a username"
		$input = Read-Host
		dk_call ${GIT_EXE} config --global user.name "${input}"
		dk_echo
		dk_info "git user.name '${input}' saved"
		dk_echo
	}
	
	if(!${message}){
		$message = "git commit"
	}
	
	dk_echo
	dk_info "git commit `"${message}`""
	dk_confirm -or return 0
	
	dk_call ${GIT_EXE} commit -a -m "${message}"
    dk_call ${GIT_EXE} push
}



function Global:DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc
	
	dk_gitCommit
}