if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_DKPLUGINS_DIR){ $dk_DKPLUGINS_DIR = 1 } else{ return } #include guard

###############################################################################
# dk_DKPLUGINS_DIR()
#
#
function Global:dk_DKPLUGINS_DIR() {
	dk_debugFunc 0 1
	
	############ SET ############
	if($($args[0])){  
		$global:DKPLUGINS_DIR = "$($args[0])" 
		return 0
	}

	############ GET ############
	dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR" 
	$global:DKPLUGINS_DIR="${DKBRANCH_DIR}/DKPlugins"   
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_echo
	dk_call dk_echo "Test Getting DKPLUGINS_DIR . . ."
	dk_call dk_DKPLUGINS_DIR
	dk_call dk_printVar DKPLUGINS_DIR
	
	dk_call dk_echo
	dk_call dk_echo "Test Setting DKPLUGINS_DIR . . ."
	dk_call dk_DKPLUGINS_DIR "C:/DK/DKPlugins"
	dk_call dk_printVar DKPLUGINS_DIR 
}
