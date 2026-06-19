if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_clearScreen_ps1){ $dk_clearScreen_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_clearScreen()
#
#
function Global:dk_clearScreen() {
	dk_debugFunc 0;

	clear
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;
	
	dk_call dk_clearScreen
}
