if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
#if(!$git_DKINSTALL_ps1){ $git_DKINSTALL_ps1 = 1; } else{ return; } #include guard

####################################################################
# dk_installGit()
#
#
function Global:DKINSTALL() {
	dk_debugFunc 0;
	
	${Import_Path}="${PSScriptRoot}";
	dk_call dk_assertPath "${Import_Path}/dkconfig.txt";
	dk_call dk_getFileParams "${Import_Path}/dkconfig.txt";
	dk_call dk_validate Host_Tuple "dk_call dk_Host_Tuple";
	dk_call dk_basename "${Import_Path}" Import_Name;
	Write-Host "Import_Name = ${Import_Name}";
	Write-Host "dk_basename = ${dk_basename}";
	
	dk_call dk_getParameterValue APP @args;
	if(${APP}) {
		dk_call dk_validate env:DKTOOLS_DIR "dk_call dk_DKTOOLS_DIR";
		${INSTALL_ROOT}="INSTALL_ROOT ${env:DKTOOLS_DIR}";
	}
	
	Write-host "${Import_Name}_${Host_Tuple}_Import";
	#dk_call dk_assertVar "${Import_Name}_${Host_Tuple}_Import";
	${PLUGIN_IMPORT}=$(gv -Name ${Import_Name}_${Host_Tuple}_Import -ValueOnly);
	dk_call dk_importVariables "$($PLUGIN_IMPORT)" ${INSTALL_ROOT};

	dk_call dk_download "${PLUGIN.Url}";
	
	dk_call dk_getExtension "${PLUGIN.Url}" "${PLUGIN.Url.Extension]}"
	if("${PLUGIN.Url.Extension}" -eq ".7z"){ 		$FileType = "Archive"; }
	if("${PLUGIN.Url.Extension}" -eq ".bz"){		$FileType = "Archive"; }	
	if("${PLUGIN.Url.Extension}" -eq ".bz2"){		$FileType = "Archive"; }
	if("${PLUGIN.Url.Extension}" -eq ".gz"){		$FileType = "Archive"; }
	if("${PLUGIN.Url.Extension}" -eq ".rar"){		$FileType = "Archive"; }
	if("${PLUGIN.Url.Extension}" -eq ".sfx.exe"){	$FileType = "Archive"; }
	if("${PLUGIN.Url.Extension}" -eq ".tar"){		$FileType = "Archive"; }
	if("${PLUGIN.Url.Extension}" -eq ".tar.gz"){	$FileType = "Archive"; }
	if("${PLUGIN.Url.Extension}" -eq ".tgz"){		$FileType = "Archive"; }
	if("${PLUGIN.Url.Extension}" -eq ".xz"){		$FileType = "Archive"; }
	if("${PLUGIN.Url.Extension}" -eq ".zip"){		$FileType = "Archive"; }
	
	if("${FileType}" -eq "Archive"){
		dk_call dk_smartExtract "${dk_download}" "${PLUGIN.Install.Path}";
	}
}	
	
	
	
	
#	dk_call dk_source "${PSScriptRoot}/dkconfig.txt";
#	dk_call dk_getFileParams ${PSScriptRoot}/dkconfig.txt;

#	dk_call dk_validate "Host_Tuple" "dk_call dk_Host_Tuple";
	#${git_Import} = ${git_$($Host_Tuple)_Import};
	
#    if(${Host_Tuple} -eq "Windows_X86"){ ${git_Import} = ${git_Windows_X86_Import}; 		}
#    if(${Host_Tuple} -eq "Windows_X86_64"){ ${git_Import} = ${git_Windows_X86_64_Import}; 	}
#    if(!${git_Import}){ dk_call dk_error "git_Import is invalid"; return ${false}; 	}
	  
#    ${GIT_IMPORT_FILE} = dk_call dk_basename ${git_Import};
#	${GIT_FOLDER}  = dk_call dk_removeExtension ${GIT_IMPORT_FILE};
#	${GIT_FOLDER}  = dk_call dk_removeExtension ${GIT_FOLDER};
#	#${GIT_FOLDER} = dk_call dk_convertToCIdentifier ${GIT_FOLDER};
#	#${GIT_FOLDER} = dk_call dk_toLower ${GIT_FOLDER};
	
#	### DO NOT USE GIT_DIR ###
#	${global:GIT} = "$(dk_call dk_DKTOOLS_DIR)/${GIT_FOLDER}";
	
#	${global:GIT_EXE} = "${GIT}/bin/git.exe";
#	${global:BASH_EXE} = "${GIT}/bin/bash.exe";
#	${global:GITBASH_EXE} = "${GIT}/git-bash.exe";
#	${global:PATCH_EXE} = "${GIT}/usr/bin/patch.exe";

#   Write-Host "GIT_EXE = ${GIT_EXE}";   
#	if(Test-Path ${GIT_EXE}){ 
#		dk_call dk_echo "Git already installed at:${GIT_EXE}";
#		return; 
#	}
        
#   dk_call dk_info "";
#    dk_call dk_info "Installing git . . .";
#	dk_call dk_download "${git_Import}" "$(dk_call dk_DKDOWNLOAD_DIR)/${GIT_IMPORT_FILE}";
#	dk_call dk_info "$(dk_call dk_DKDOWNLOAD_DIR)/${GIT_IMPORT_FILE} -y -o ${GIT}";
#	dk_call ${env:COMSPEC} /c "$(dk_call dk_DKDOWNLOAD_DIR)/${GIT_IMPORT_FILE}" -y -o ${GIT};
#	   
#    if(!(dk_call dk_pathExists ${GIT_EXE})){ dk_call dk_error "cannot find git"; }
#}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;
	
    dk_call DKINSTALL
}
