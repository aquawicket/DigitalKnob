if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
#if(!$git_DKINSTALL_ps1){ $git_DKINSTALL_ps1 = 1; } else{ return; } #include guard

####################################################################
# dk_installGit()
#
#
function Global:DKINSTALL() {
	dk_debugFunc 0;
	
	${global:CURRENT_IMPORT}=${PSScriptRoot} -replace "\\", "/";
	dk_call dk_import APP;
	
	### DO NOT USE GIT_DIR ###
	# ${global:GIT} = "$(dk_call dk_DKTOOLS_DIR)/${GIT_FOLDER}";

	${global:GIT_EXE} = "${GIT}/bin/git.exe";
	${global:GIT_BASH_EXE} = "${GIT}/bin/bash.exe";
	#${global:GITBASH_EXE} = "${GIT}/git-bash.exe";
	#${global:PATCH_EXE} = "${GIT}/usr/bin/patch.exe";
	
	dk_call dk_echo "GIT_EXE = ${GIT_EXE}";
	
	if(dk_call dk_pathExists "${GIT_EXE}"){ return; }
	if(Test-Path ${GIT_EXE}){ 
		dk_call dk_echo "Git already installed at:${GIT_EXE}";
		return; 
	}
	
	&${env:COMSPEC} /c "${dk_download}" -y -o ${GIT};
	#dk_call ${env:COMSPEC} /c "$(dk_call dk_DKDOWNLOAD_DIR)/${GIT_IMPORT_FILE}" -y -o ${GIT};
	
	if(!(dk_call dk_pathExists ${GIT_EXE})){ dk_call dk_error "GIT_EXE:${GIT_EXE} not found"; }
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;
	
    dk_call DKINSTALL
}
