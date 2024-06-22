if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_pickType){ $dk_pickType = 1 } else{ return }

##################################################################################
# dk_pickType()
#
#
function Global:dk_pickType() {
	dk_debugFunc
	if($(__ARGC__) -ne 0){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }


	dk_echo
	dk_echo "${APP} ${TARGET_OS} ${TYPE}"
	dk_echo	
    dk_echo " 1) Debug"
	dk_echo " 2) Release"
	dk_echo " 3) All"
	dk_echo " 4) Clear Screen"
	dk_echo " 5) Go Back"
	dk_echo " 6) Exit"
	dk_echo
	
	$input = Read-Host
	    if(${input} -eq "1"){ $global:TYPE = "Debug" }
	elseif(${input} -eq "2"){ $global:TYPE = "Release" }
	elseif(${input} -eq "3"){ $global:TYPE = "All" }
	elseif(${input} -eq "4"){ dk_clearScreen }
	elseif(${input} -eq "5"){ dk_unset TARGET_OS }
	elseif(${input} -eq "6"){ dk_exit 0 }
	else{ dk_warning "invalid selection" }
}



function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	
	dk_pickType
}