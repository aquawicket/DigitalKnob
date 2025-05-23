if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_target_type){ $dk_target_type = 1 } else{ return } #include guard

##################################################################################
# dk_target_type()
#
#
function Global:dk_target_type() {
	dk_debugFunc 0

	dk_call dk_echo
	dk_call dk_echo "${target_app} ${target_triple} ${target_type}"
	dk_call dk_echo	
    dk_call dk_echo " 1) Debug"
	dk_call dk_echo " 2) Release"
	dk_call dk_echo " 3) All"
	dk_call dk_echo " 4) Clear Screen"
	dk_call dk_echo " 5) Go Back"
	dk_call dk_echo " 6) Exit"
	dk_call dk_echo
	
	$input = Read-Host
	    if(${input} -eq "1"){ $global:target_type = "Debug" }
	elseif(${input} -eq "2"){ $global:target_type = "Release" }
	elseif(${input} -eq "3"){ $global:target_type = "All" }
	elseif(${input} -eq "4"){ dk_call dk_clearScreen }
	elseif(${input} -eq "5"){ dk_call dk_unset target_triple }
	elseif(${input} -eq "6"){ dk_call dk_exit 0 }
	else{ dk_call dk_warning "invalid selection" }
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_target_type
}
