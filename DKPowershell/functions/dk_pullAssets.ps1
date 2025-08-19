if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_pullAssets_ps1){ $dk_pullAssets_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_pullAssets()
#
#
function Global:dk_pullAssets() {
	dk_debugFunc 0;
	
    dk_call dk_fixme "dk_pullAssets() NOT implemented"
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;
	
	dk_call dk_pullAssets
}
