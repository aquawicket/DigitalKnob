if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!${$PSCommandPath}){ ${$PSCommandPath} = 1 } else{ return } #include guard

####################################################################
# dk_DKDESKTOP_DIR()
#
#
function Global:dk_DKDESKTOP_DIR() {
    dk_debugFunc 0 1

	############ SET ############
	if($($args[0])){  
		$global:DKDESKTOP_DIR = "$($args[0])" 
		return 0
	}
	
	############ GET ############
	dk_call dk_validate DKHOME_DIR "dk_call dk_DKHOME_DIR" 
	$global:DKDESKTOP_DIR = "${DKHOME_DIR}/Desktop" 
	
	if(!(Test-Path $DKDESKTOP_DIR)){ 
		dk_call dk_makeDirectory "${DKDESKTOP_DIR}" 
	}
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST() {
    dk_debugFunc 0 
   
	dk_call dk_echo
	dk_call dk_echo "Test Getting DKDESKTOP_DIR . . ."
	dk_call dk_DKDESKTOP_DIR
	dk_call dk_printVar DKDESKTOP_DIR
	
	dk_call dk_echo
	dk_call dk_echo "Test Setting DKDESKTOP_DIR . . ."
	dk_call dk_DKDESKTOP_DIR "C:/Desktop"
	dk_call dk_printVar DKDESKTOP_DIR 
}
