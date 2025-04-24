<<<<<<< HEAD
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_gitCommit){ $dk_gitCommit = 1 } else{ return }
=======
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_gitCommit){ $dk_gitCommit = 1 } else{ return } #include guard
>>>>>>> Development

##################################################################################
# dk_gitCommit()
#
#
function Global:dk_gitCommit() {	
	dk_debugFunc 0
	
	dk_call dk_gitDiffSummary
	
	dk_call dk_info "Please enter some details about this commit, Then press ENTER."
	$message = Read-Host
	
	dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR"
	cd "${DKBRANCH_DIR}" #-or dk_call dk_error "cd \${DKBRANCH_DIR} failed!"
	
	dk_call dk_validate GIT_EXE "dk_call dk_installGit"
	
	if(!($STORE = $(dk_call ${GIT_EXE} config credential.helper))){
		dk_call dk_errorStatus
	}
	if(!${STORE}){
		dk_call ${GIT_EXE} config --global credential.helper store
		dk_call dk_echo
		dk_call dk_info "git credential.helper is now set to store"
		dk_call dk_echo
	}
	
	if(!($USER_EMAIL = $(dk_call ${GIT_EXE} config --global user.email))){
		dk_call dk_errorStatus
	}
	if(!${USER_EMAIL}){
		dk_call dk_echo
		dk_call dk_info "please enter an email address"
		$input = Read-Host
		dk_call ${GIT_EXE} config --global user.email "${input}"
		dk_call dk_echo
		dk_call dk_info "git user.email '${input}' saved"
		dk_call dk_echo
	}
	if(!($USER_NAME = $(dk_call ${GIT_EXE} config --global user.name))){
		dk_call dk_errorStatus
	}
	if(!${USER_NAME}){
		dk_call dk_echo
		dk_call dk_info "please enter a username"
		$input = Read-Host
		dk_call ${GIT_EXE} config --global user.name "${input}"
		dk_call dk_echo
		dk_call dk_info "git user.name '${input}' saved"
		dk_call dk_echo
	}
	
	if(!${message}){
		$message = "git commit"
	}
	
	dk_call dk_echo
	dk_call dk_info "git commit `"${message}`""
	dk_call dk_confirm -or return 0
	
	dk_call ${GIT_EXE} commit -a -m "${message}"
    dk_call ${GIT_EXE} push
}









###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_gitCommit
}
