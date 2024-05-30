!!!!   FIXME   !!!!


if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$dk_errorStatus){ $dk_errorStatus = 1 } else{ return }

dk_load dk_echo
##################################################################################
# dk_confirm()
#
#
function Global:dk_confirm() {
	dk_debugFunc
	if($(__ARGC__) -ne 0){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }

	dk_echo "${yellow} Are you sure ? [Y/N] ${clr}"
	$REPLY = Read-Host
	dk_echo
	dk_echo
	return $false
	if("$REPLY" -eq "y"){ 
		return $true 
	} elseif("$REPLY" -eq "Y"){ 
		return $true 
	} else {
		return $false
	}
}





function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	
	if(dk_confirm){ 
		echo "the confimation has passed"
	} else {
		echo "the confimation has failed"
	}
}