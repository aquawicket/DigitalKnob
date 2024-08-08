if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_pushAssets){ $dk_pushAssets = 1 } else{ return }

##################################################################################
# dk_pushAssets()
#
#
function Global:dk_pushAssets() {
	dk_debugFunc 0
	
    dk_todo
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_pushAssets

}