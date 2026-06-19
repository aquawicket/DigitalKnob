if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_confirm_ps1){ $dk_confirm_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_confirm()
#
#
function Global:dk_confirm() {
	dk_debugFunc 0 99;

    $confirmation = Read-Host "${yellow} Are you sure ? [Y/N] ${clr}"
	if($confirmation -eq 'y' -or $confirmation -eq 'Y') { $confirm = $true }
	else{ $confirm = $false }
	dk_call dk_printVar confirm
	return $confirm
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;
	
	if(dk_call dk_confirm){ dk_call dk_echo "the confimation has passed\n" } 
	else{ dk_call dk_echo "the confimation has failed\n" }
}