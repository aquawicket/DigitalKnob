if(!$DKINIT){ .${env:DKPOWERSHELL_FUNCTIONS_DIR}\DK.ps1 }
if(!$dk_makeDirectory){ $dk_makeDirectory = 1 } else{ return }

####################################################################
# dk_makeDirectory(path)
#
#
function Global:dk_makeDirectory ($_path_) {
	dk_debugFunc
	
	
	if(!(Test-Path $_path_)){ 
		New-Item -Path "$_path_" -ItemType Directory 
	}
}




function Global:DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### 
	dk_debugFunc
	
	
	dk_makeDirectory "MadeDirectory"
}