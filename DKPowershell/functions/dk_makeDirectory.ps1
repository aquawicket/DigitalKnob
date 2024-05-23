if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$dk_makeDirectory){ $dk_makeDirectory = 1 } else{ return }

dk_load dk_info
####################################################################
# dk_makeDirectory(<path>)
#
#
function Global:dk_makeDirectory ($_path_) {
	dk_debugFunc
	
	if (! (Test-Path $_path_)){ dk_info "create directory" }
}




function Global:DKTEST() { ###########################################################################################
	
	dk_makeDirectory "MadeDirectory"
	
}