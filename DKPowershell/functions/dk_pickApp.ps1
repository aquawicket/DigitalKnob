if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_pickApp){ $dk_pickApp = 1 } else{ return }

##################################################################################
# dk_pickApp()
#
#
function Global:dk_pickApp() {
	dk_debugFunc
	if($(__ARGC__) -ne 0){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }


	dk_echo
	dk_echo "${APP} ${TARGET_OS} ${TYPE}"
	
	dk_echo
    dk_echo " 1) HelloWorld"
    dk_echo " 2) DKCore"
    dk_echo " 3) DKJavascript"
    dk_echo " 4) DKSDL"
    dk_echo " 5) DKSDLRml"
    dk_echo " 6) DKDomTest"
    dk_echo " 7) DKTestAll"
    dk_echo " 8) Enter Manually"
    dk_echo " 9) Clear Screen"
    dk_echo "10) Go Back"
    dk_echo "11) Reload"
	dk_echo "12) Exit"
    dk_echo 
	
	$input = Read-Host
	    if($input -eq  "1"){ $global:APP = "HelloWorld" }
	elseif($input -eq  "2"){ $global:APP = "DKCore" }
	elseif($input -eq  "3"){ $global:APP = "DKJavascript" }
	elseif($input -eq  "4"){ $global:APP = "DKSDL" }
	elseif($input -eq  "5"){ $global:APP = "DKSDLRml" }
	elseif($input -eq  "6"){ $global:APP = "DKDomTest" }
	elseif($input -eq  "7"){ $global:APP = "DKTestAll" }
	elseif($input -eq  "8"){ dk_enterManually }
	elseif($input -eq  "9"){ dk_clearScreen }
	elseif($input -eq "10"){ dk_unset UPDATE }
	elseif($input -eq "11"){ dk_reload }
	elseif($input -eq "12"){ dk_exit 0 }
	else{ dk_warning "invalid selection" }
}



function Global:DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc
	
	
	dk_pickApp
}