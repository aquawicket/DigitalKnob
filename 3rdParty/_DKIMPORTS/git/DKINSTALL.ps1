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
	# ${global:git} = "$(dk_call dk_DKTOOLS_DIR)/${git_Folder}";

	${global:git_exe} = "${git}/bin/git.exe";
	${global:git_bash_exe} = "${git}/bin/bash.exe";
	#${global:gitbash_exe} = "${git}/git-bash.exe";
	#${global:patch_exe} = "${git}/usr/bin/patch.exe";
	
	dk_call dk_echo "git_exe = ${git_exe}";
	
	if(dk_call dk_pathExists "${git_exe}"){ return; }
	if(Test-Path "${git_exe}"){ 
		dk_call dk_echo "Git already installed at:${git_exe}";
		return; 
	}
	
	&${env:ComSpec} /c "${dk_download}" -y -o ${git};
	#dk_call ${env:COMSPEC} /c "$(dk_call dk_DKDOWNLOAD_DIR)/${git_Import_File}" -y -o ${git};
	
	if(!(dk_call dk_pathExists ${git_exe})){ dk_call dk_error "git_exe:${git_exe} NOT found"; }
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;
	
    dk_call DKINSTALL;
}
