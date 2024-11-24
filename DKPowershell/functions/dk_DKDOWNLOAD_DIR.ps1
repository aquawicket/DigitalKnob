if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_DKDOWNLOAD_DIR){ $dk_DKDOWNLOAD_DIR = 1 } else{ return }

####################################################################
# dk_DKDOWNLOAD_DIR()
#
#
function Global:dk_DKDOWNLOAD_DIR() {
    dk_debugFunc 0 1

	############ SET ############
	if($($args[0])){  
		$global:DKDOWNLOAD_DIR = "$($args[0])" 
		return 0
	}
	
	############ GET ############
	dk_call dk_validate DIGITALKNOB_DIR "dk_call dk_DIGITALKNOB_DIR" 
	$global:DKDOWNLOAD_DIR = "${DIGITALKNOB_DIR}/download" 
	
	if(!(Test-Path $DKDOWNLOAD_DIR)){ 
		dk_call dk_makeDirectory "${DKDOWNLOAD_DIR}" 
	}
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST() {
    dk_debugFunc 0 
   
	dk_call dk_echo
	dk_call dk_echo "Test Getting DKDOWNLOAD_DIR . . ."
	dk_call dk_DKDOWNLOAD_DIR
	dk_call dk_printVar DKDOWNLOAD_DIR
	
	dk_call dk_echo
	dk_call dk_echo "Test Setting DKDOWNLOAD_DIR . . ."
	dk_call dk_DKDOWNLOAD_DIR "C:/DK/download"
	dk_call dk_printVar DKDOWNLOAD_DIR 
}
