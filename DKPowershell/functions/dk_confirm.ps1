if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_confirm){ $dk_confirm = 1 } else{ return }

##################################################################################
# dk_confirm()
#
#
function Global:dk_confirm() {
	dk_debugFunc
	if($(__ARGC__) -ne 0){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }


    $confirmation = Read-Host "${yellow} Are you sure ? [Y/N] ${clr}"
	if($confirmation -eq 'y' -or $confirmation -eq 'Y') { return $true }
	return $false
}





function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	
	if(dk_confirm){
		echo "the confimation has passed"
	} else {
		echo "the confimation has failed"
	}
}