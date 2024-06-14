if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_pullAssets){ $dk_pullAssets = 1 } else{ return }


##################################################################################
# dk_pullAssets()
#
#
function Global:dk_pullAssets () {
	dk_debugFunc
	
	
    dk_fixme "dk_pullAssets() not implemented"
}




function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	
	dk_pullAssets
}