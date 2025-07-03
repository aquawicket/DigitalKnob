if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_installGit_ps1){ $dk_installGit_ps1 = 1; } else{ return; } #include guard

####################################################################
# dk_installGit()
#
#
function Global:DKINSTALL() {
	dk_debugFunc 0;
	
	dk_call dk_getFileParams ${PSScriptRoot}/dkconfig.txt
	#${Git_Windows_X86_Import}    = "https://github.com/git-for-windows/git/releases/download/v2.46.2.windows.1/PortableGit-2.46.2-32-bit.7z.exe"
	#${Git_Windows_X86_64_Import} = "https://github.com/git-for-windows/git/releases/download/v2.46.2.windows.1/PortableGit-2.46.2-64-bit.7z.exe"

	dk_call dk_validate "Host_Arch" "dk_call dk_Host_Arch"
    if(${Host_Arch} -eq "Arm32") { ${GIT_DL} = ${Git_Windows_Arm32_Import} }
    if(${Host_Arch} -eq "Arm64") { ${GIT_DL} = ${Git_Windows_Arm64_Import} }
    if(${Host_Arch} -eq "X86")   { ${GIT_DL} = ${Git_Windows_X86_Import} }
    if(${Host_Arch} -eq "X86_64"){ ${GIT_DL} = ${Git_Windows_X86_64_Import} }
    if(!${GIT_DL}){ dk_call dk_error "GIT_DL is invalid"; return ${false} }
	  
    ${GIT_IMPORT_FILE} = dk_call dk_basename ${GIT_DL}
	${GIT_FOLDER}  = dk_call dk_removeExtension ${GIT_IMPORT_FILE}
	${GIT_FOLDER}  = dk_call dk_removeExtension ${GIT_FOLDER}
	#${GIT_FOLDER} = dk_call dk_convertToCIdentifier ${GIT_FOLDER} 
	#${GIT_FOLDER} = dk_call dk_toLower ${GIT_FOLDER}
	
	### DO NOT USE GIT_DIR ###
	${global:GIT} = "$(dk_call dk_DKTOOLS_DIR)/${GIT_FOLDER}"
	
	${global:GIT_EXE} = "${GIT}/bin/git.exe"
	${global:BASH_EXE} = "${GIT}/bin/bash.exe"
	${global:GITBASH_EXE} = "${GIT}/git-bash.exe"
	${global:PATCH_EXE} = "${GIT}/usr/bin/patch.exe"

        
    if(dk_call dk_pathExists ${GIT_EXE}){ return }
        
    dk_call dk_info ""  
    dk_call dk_info "Installing git . . ."
    dk_call dk_download ${GIT_DL} $(dk_call dk_DKDOWNLOAD_DIR)/${GIT_IMPORT_FILE}
	dk_call dk_info "${DKDOWNLOAD_DIR}/${GIT_IMPORT_FILE} -y -o ${GIT}"
	dk_call ${env:COMSPEC} /c "${DKDOWNLOAD_DIR}/${GIT_IMPORT_FILE}" -y -o ${GIT}
	   
    if(!(dk_call dk_pathExists ${GIT_EXE})){ dk_call dk_error "cannot find git" }
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;
	
    dk_call DKINSTALL
}
