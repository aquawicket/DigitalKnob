if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_keyboardInput_ps1){ $dk_keyboardInput_ps1 = 1; } else{ return; } #include guard


################################################################################
# dk_keyboardInput()
#
#
function Global:dk_keyboardInput() {
	dk_debugFunc 0 99;

	${global:dk_keyboardInput} = Read-Host;
	return $dk_keyboardInput;
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;

	dk_call dk_keyboardInput;
}
