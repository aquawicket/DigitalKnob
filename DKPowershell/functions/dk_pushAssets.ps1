if(!$DKINIT){ .${env:DKPOWERSHELL_FUNCTIONS_DIR}\DK.ps1 }
if(!$dk_pushAssets){ $dk_pushAssets = 1 } else{ return }

##################################################################################
# dk_pushAssets()
#
#
function Global:dk_pushAssets() {
	dk_debugFunc
	
    dk_todo
}




function Global:DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc
	
	dk_pushAssets

}