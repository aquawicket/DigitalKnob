if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_gitCommit_ps1){ $dk_gitCommit_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_gitCommit()
#
#
function Global:dk_gitCommit() {	
	dk_debugFunc 0;
	
	dk_call dk_gitDiffSummary
	
	dk_call dk_info "Please enter some details about this commit, Then press ENTER."
	$message = Read-Host
	
	dk_call dk_validate env:DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR"
	cd "${DKBRANCH_DIR}" #-or dk_call dk_error "cd \${DKBRANCH_DIR} failed!"
	
	dk_call dk_validate git_exe "dk_call dk_installGit";
	
	if(!($STORE = $(dk_call ${git_exe} config credential.helper))){
		dk_call dk_errorStatus;
	}
	if(!${STORE}){
		dk_call ${git_exe} config --global credential.helper store
		dk_call dk_echo "\n";
		dk_call dk_info "git credential.helper is now set to store\n";
		dk_call dk_echo "\n";
	}
	
	if(!($USER_EMAIL = $(dk_call ${git_exe} config --global user.email))){
		dk_call dk_errorStatus;
	}
	if(!${USER_EMAIL}){
		dk_call dk_echo "\n";
		dk_call dk_info "please enter an email address\n";
		$input = Read-Host;
		dk_call ${git_exe} config --global user.email "${input}";
		dk_call dk_echo "\n";
		dk_call dk_info "git user.email '${input}' saved\n";
		dk_call dk_echo "\n";
	}
	if(!($USER_NAME = $(dk_call ${git_exe} config --global user.name))){
		dk_call dk_errorStatus
	}
	if(!${USER_NAME}){
		dk_call dk_echo "\n";
		dk_call dk_info "please enter a username\n";
		$input = Read-Host
		dk_call ${git_exe} config --global user.name "${input}"
		dk_call dk_echo "\n";
		dk_call dk_info "git user.name '${input}' saved\n";
		dk_call dk_echo "\n";
	}
	
	if(!${message}){
		$message = "git commit";
	}
	
	dk_call dk_echo "\n";
	dk_call dk_info "git commit `"${message}`"\n";
	dk_call dk_confirm -or return 0;
	
	dk_call ${git_exe} commit -a -m "${message}";
    dk_call ${git_exe} push;
}









###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;
	
	dk_call dk_gitCommit
}
