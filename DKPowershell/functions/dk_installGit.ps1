if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_installGit_ps1){ $dk_installGit_ps1 = 1; } else{ return; } #include guard

####################################################################
# dk_installGit()
#
#
function Global:dk_installGit() {
	dk_debugFunc 0;
	
	if( !(dk_call dk_pathExists $(dk_call dk_DKIMPORTS_DIR)/git/DKINSTALL.cmd) ){
		${DKHTTP_DKIMPORTS_DIR} = "https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/3rdParty/_DKIMPORTS"
		dk_call dk_download "${DKHTTP_DKIMPORTS_DIR}/git/DKINSTALL.ps1"  "$(dk_call dk_DKIMPORTS_DIR)/git/DKINSTALL.ps1"
	}
	dk_call dk_depend git
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;
	
    dk_call dk_installGit
}
