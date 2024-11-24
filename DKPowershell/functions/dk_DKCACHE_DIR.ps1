if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_DKCACHE_DIR){ $dk_DKCACHE_DIR = 1 } else{ return }

####################################################################
# dk_DKCACHE_DIR()
#
#
function Global:dk_DKCACHE_DIR() {
    dk_debugFunc 0 1

	############ SET ############
	if($($args[0])){  
		$global:DKCACHE_DIR = "$($args[0])" 
		return 0
	}
	
	############ GET ############
	dk_call dk_validate DKHOME_DIR "dk_call dk_DKHOME_DIR" 
	$global:DKCACHE_DIR = "${DKHOME_DIR}/.dk" 
	
	if(!(Test-Path $DKCACHE_DIR)){ 
		dk_call dk_makeDirectory "${DKCACHE_DIR}" 
	}
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST() {
    dk_debugFunc 0 
   
	dk_call dk_echo
	dk_call dk_echo "Test Getting DKCACHE_DIR . . ."
	dk_call dk_DKCACHE_DIR
	dk_call dk_printVar DKCACHE_DIR
	
	dk_call dk_echo
	dk_call dk_echo "Test Setting DKCACHE_DIR . . ."
	dk_call dk_DKCACHE_DIR "C:/.dk"
	dk_call dk_printVar DKCACHE_DIR 
}
