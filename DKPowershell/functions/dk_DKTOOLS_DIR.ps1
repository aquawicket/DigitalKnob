if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!${$PSCommandPath}){ ${$PSCommandPath} = 1 } else{ return } #include guard

####################################################################
# dk_DKTOOLS_DIR()
#
#
function Global:dk_DKTOOLS_DIR() {
    dk_debugFunc 0 1

	############ SET ############
	if($($args[0])){  
		$global:DKTOOLS_DIR = "$($args[0])" 
		return 0
	}
	
	############ GET ############
	dk_call dk_validate DIGITALKNOB_DIR "dk_call dk_DIGITALKNOB_DIR" 
	$global:DKTOOLS_DIR = "${DIGITALKNOB_DIR}/DKTools" 
	
	if(!(Test-Path $DKTOOLS_DIR)){ 
		dk_call dk_makeDirectory "${DKTOOLS_DIR}" 
	}
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST() {
    dk_debugFunc 0 
   
	dk_call dk_echo
	dk_call dk_echo "Test Getting DKTOOLS_DIR . . ."
	dk_call dk_DKTOOLS_DIR
	dk_call dk_printVar DKTOOLS_DIR
	
	dk_call dk_echo
	dk_call dk_echo "Test Setting DKTOOLS_DIR . . ."
	dk_call dk_DKTOOLS_DIR "C:/DK/DKTools"
	dk_call dk_printVar DKTOOLS_DIR 
}
