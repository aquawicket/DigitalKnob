<<<<<<< HEAD
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_pullAssets){ $dk_pullAssets = 1 } else{ return }
=======
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_pullAssets){ $dk_pullAssets = 1 } else{ return } #include guard
>>>>>>> Development

##################################################################################
# dk_pullAssets()
#
#
function Global:dk_pullAssets() {
	dk_debugFunc 0
	
    dk_call dk_fixme "dk_pullAssets() not implemented"
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_pullAssets
}
