if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_gitUpdate_ps1){ $dk_gitUpdate_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_gitUpdate(url, branch, NO_CONFIRM)
#
#
function Global:dk_gitUpdate() {
	dk_debugFunc 0 3;
	
	${dk_gitUpdate_BACKUP} = 1;
	if($($args[0])){ ${_url_} = $($args[0]); }    		else { ${_url_} = "https://github.com/aquawicket/DigitalKnob.git"; }
	if($($args[1])){ ${env:DKBRANCH} = $($args[1]); } 	else { ${env:DKBRANCH} = "Development"; }
	
#	if(!($args[2] -eq "NO_CONFIRM")){
#		dk_call dk_info "Git Update? Any local changes will be lost.";
#		if(!(dk_call dk_confirm)){ return 0; }
#	}

	dk_call dk_validate git_exe "dk_call dk_installGit";
	if( !(dk_call dk_pathExists "${env:DKBRANCH_DIR}/.git") ){
		if(dk_call dk_pathExists "${env:DKBRANCH_DIR}"){
			###### Backup Branch directory AND clone ######
			if("${dk_gitUpdate_BACKUP}" -eq "1"){
				dk_call dk_copy "${env:DKBRANCH_DIR}" "${env:DKBRANCH_DIR}_BACKUP" OVERWRITE;
			}
			Remove-Item -Recurse -Force "${env:DKBRANCH_DIR}";
			dk_call "${git_exe}" clone ${_url_} "${env:DKBRANCH_DIR}";
			dk_call "${git_exe}" -C ${env:DKBRANCH_DIR} pull --all;
			dk_call "${git_exe}" -C ${env:DKBRANCH_DIR} checkout -- .;
			dk_call "${git_exe}" -C ${env:DKBRANCH_DIR} checkout ${env:DKBRANCH}; # || {
#				dk_call dk_echo "Remote has no '${env:DKBRANCH}' branch. Creating...";
#				dk_call "${git_exe}" -C ${env:DKBRANCH_DIR} checkout -b ${env:DKBRANCH} main;
#				dk_call "${git_exe}" -C ${env:DKBRANCH_DIR} push --set-upstream origin ${env:DKBRANCH};
#			}
			return;
		}

		dk_call "${git_exe}" clone "${url}" "${env:DKBRANCH_DIR}";
	}
	
	###### Update ######
	#dk_call cd "${env:DKBRANCH_DIR}" #-or dk_call dk_error "cd $${DKBRANCH_DIR} failed!"
	dk_call "${git_exe}" -C ${env:DKBRANCH_DIR} pull --all;
	dk_call "${git_exe}" -C ${env:DKBRANCH_DIR} checkout -- .;
	dk_call "${git_exe}" -C ${env:DKBRANCH_DIR} checkout ${env:DKBRANCH};
	if( $? -eq "0" ){
		dk_call dk_info "${env:DKBRANCH} branch selected";
	} else {
		dk_call dk_info "Remote has no ${env:DKBRANCH} branch. Creating...";
		dk_call "${git_exe}" -C ${env:DKBRANCH_DIR} checkout -b ${env:DKBRANCH} main;
		dk_call "${git_exe}" -C ${env:DKBRANCH_DIR} push --set-upstream origin ${env:DKBRANCH};
	}
	#dk_call chmod +x "${env:DKBRANCH_DIR}"/build;
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;
	
	dk_call dk_gitUpdate https://github.com/aquawicket/DigitalKnob.git Development;
}
