if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_DK3RDPARTY_DIR){ $dk_DK3RDPARTY_DIR = 1 } else{ return }

###############################################################################
# dk_DK3RDPARTY_DIR()
#
#
function Global:dk_DK3RDPARTY_DIR() {
	dk_debugFunc 0 1
	
	############ SET ############
	if($($args[0])){  
		$global:DK3RDPARTY_DIR = "$($args[0])" 
		return 0
	}

	############ GET ############
	dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR" 
	$global:DK3RDPARTY_DIR="${DKBRANCH_DIR}/3rdParty"   
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_echo
	dk_call dk_echo "Test Getting DK3RDPARTY_DIR . . ."
	dk_call dk_DK3RDPARTY_DIR
	dk_call dk_printVar DK3RDPARTY_DIR
	
	dk_call dk_echo
	dk_call dk_echo "Test Setting DK3RDPARTY_DIR . . ."
	dk_call dk_DK3RDPARTY_DIR "C:/DK/3rdParty"
	dk_call dk_printVar DK3RDPARTY_DIR 
}
