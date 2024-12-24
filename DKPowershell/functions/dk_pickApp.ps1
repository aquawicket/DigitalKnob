if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!${$PSCommandPath}){ ${$PSCommandPath} = 1 } else{ return } #include guard

##################################################################################
# dk_pickApp()
#
#
function Global:dk_pickApp() {
	dk_debugFunc 0
	
	dk_call dk_echo
	dk_call dk_echo "${APP} ${triple} ${TYPE}"
	
	dk_call dk_echo
    dk_call dk_echo " 1) HelloWorld"
    dk_call dk_echo " 2) DKCore"
    dk_call dk_echo " 3) DKJavascript"
    dk_call dk_echo " 4) DKSDL"
    dk_call dk_echo " 5) DKSDLRml"
    dk_call dk_echo " 6) DKDomTest"
    dk_call dk_echo " 7) DKTestAll"
    dk_call dk_echo " 8) Enter Manually"
    dk_call dk_echo " 9) Clear Screen"
    dk_call dk_echo "10) Go Back"
    dk_call dk_echo "11) Reload"
	dk_call dk_echo "12) Exit"
    dk_call dk_echo 
	
	$input = Read-Host
	    if($input -eq  "1"){ $global:APP = "HelloWorld" }
	elseif($input -eq  "2"){ $global:APP = "DKCore" }
	elseif($input -eq  "3"){ $global:APP = "DKJavascript" }
	elseif($input -eq  "4"){ $global:APP = "DKSDL" }
	elseif($input -eq  "5"){ $global:APP = "DKSDLRml" }
	elseif($input -eq  "6"){ $global:APP = "DKDomTest" }
	elseif($input -eq  "7"){ $global:APP = "DKTestAll" }
	elseif($input -eq  "8"){ dk_call dk_enterManually }
	elseif($input -eq  "9"){ dk_call dk_clearScreen }
	elseif($input -eq "10"){ dk_call dk_unset UPDATE }
	elseif($input -eq "11"){ dk_call dk_reload }
	elseif($input -eq "12"){ dk_call dk_exit 0 }
	else{ dk_call dk_warning "invalid selection" }
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_pickApp
}
