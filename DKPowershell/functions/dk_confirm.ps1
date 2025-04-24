<<<<<<< HEAD
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_confirm){ $dk_confirm = 1 } else{ return }
=======
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_confirm){ $dk_confirm = 1 } else{ return } #include guard
>>>>>>> Development

##################################################################################
# dk_confirm()
#
#
function Global:dk_confirm() {
	dk_debugFunc 0

    $confirmation = Read-Host "${yellow} Are you sure ? [Y/N] ${clr}"
	if($confirmation -eq 'y' -or $confirmation -eq 'Y') { $confirm = $true }
	else{ $confirm = $false }
	dk_call dk_printVar confirm
	return $confirm
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	if(dk_call dk_confirm){ dk_call dk_echo "the confimation has passed" } 
	else{ dk_call dk_echo "the confimation has failed" }
}