if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_DKAPPS_DIR){ $dk_DKAPPS_DIR = 1 } else{ return } #include guard

###############################################################################
# dk_DKAPPS_DIR()
#
#
function Global:dk_DKAPPS_DIR() {
	dk_debugFunc 0 1
	
	############ SET ############
	if($($args[0])){  
		$global:DKAPPS_DIR = "$($args[0])" 
		return 0
	}

	############ GET ############
	dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR" 
	$global:DKAPPS_DIR="${DKBRANCH_DIR}/DKApps"   
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_echo
	dk_call dk_echo "Test Getting DKAPPS_DIR . . ."
	dk_call dk_DKAPPS_DIR
	dk_call dk_printVar DKAPPS_DIR
	
	dk_call dk_echo
	dk_call dk_echo "Test Setting DKAPPS_DIR . . ."
	dk_call dk_DKAPPS_DIR "C:/DK/DKApps"
	dk_call dk_printVar DKAPPS_DIR 
}
