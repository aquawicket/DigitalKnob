if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_DKHOME_DIR){ $dk_DKHOME_DIR = 1 } else{ return } #include guard

####################################################################
# dk_getDKPaths()
#
#
function Global:dk_DKHOME_DIR() {
	dk_debugFunc 0 1

	############ SET ############
	if($($args[0])){  
		$global:DKHOME_DIR = "$($args[0])" 
		return 0
	}
	
	############ GET ############
	### DKHOME_DIR ###
	$global:DKHOME_DIR = "$env:USERPROFILE"
	$global:DKHOME_DIR = $DKHOME_DIR -replace '\\', '/';
	dk_call dk_assertPath DKHOME_DIR
	
#	### DKCACHE_DIR ###
#	$global:DKCACHE_DIR = "${DKHOME_DIR}/.dk"
#   dk_call dk_mkdir $DKCACHE_DIR
#	dk_call dk_assertPath DKCACHE_DIR
	
#	### DKDESKTOP_DIR ###
#	$global:DKDESKTOP_DIR = "${DKHOME_DIR}/Desktop"
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0
	
	dk_call dk_echo
	dk_call dk_echo "Test Getting DKHOME_DIR . . ."
    dk_call dk_DKHOME_DIR
    dk_call dk_printVar DKHOME_DIR
	
	dk_call dk_echo
	dk_call dk_echo "Test Setting DKHOME_DIR . . ."
	dk_call dk_DKHOME_DIR "C:/"
	dk_call dk_printVar DKHOME_DIR 
}
