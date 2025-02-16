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
		$global:DKCPP_APPS_DIR = "$($args[0])" 
		return 0
	}

	############ GET ############
	dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR" 
	$global:DKCPP_APPS_DIR="${DKBRANCH_DIR}/DKCpp/DKCpp/apps"   
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_echo
	dk_call dk_echo "Test Getting DKCPP_APPS_DIR . . ."
	dk_call dk_DKAPPS_DIR
	dk_call dk_printVar DKCPP_APPS_DIR
	
	dk_call dk_echo
	dk_call dk_echo "Test Setting DKCPP_APPS_DIR . . ."
	dk_call dk_DKAPPS_DIR "C:/DK/DKCpp/apps"
	dk_call dk_printVar DKCPP_APPS_DIR 
}
