if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_DIGITALKNOB_DIR){ $dk_DIGITALKNOB_DIR = 1 } else{ return } #include guard

####################################################################
# dk_DIGITALKNOB_DIR()
#
#
function Global:dk_DIGITALKNOB_DIR() {
	dk_debugFunc 0 1
	
	############ SET ############
	if($($args[0])){  
		$global:DIGITALKNOB_DIR = "$($args[0])" 
		return 0
	}
	
	############ GET ############
	dk_call dk_validate DKHOME_DIR  "dk_call dk_DKHOME_DIR"

	### DIGITALKNOB_DIR ###
	$global:DIGITALKNOB="digitalknob"
	$global:DIGITALKNOB_DIR="${DKHOME_DIR}/${DIGITALKNOB}"
	dk_call dk_makeDirectory $DIGITALKNOB_DIR

#		### DKDOWNLOAD_DIR ###
#		$global:DKDOWNLOAD_DIR = "${DIGITALKNOB_DIR}/download"
#		dk_call dk_makeDirectory $DKDOWNLOAD_DIR
	
#		### DKTOOLS_DIR ###
#		$global:DKTOOLS_DIR = "${DIGITALKNOB_DIR}/DKTools"
#		dk_call dk_makeDirectory $DKTOOLS_DIR
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0
	
	dk_call dk_echo
	dk_call dk_echo "Test Getting DIGITALKNOB_DIR . . ."
    dk_call dk_DIGITALKNOB_DIR
    dk_call dk_printVar DIGITALKNOB_DIR
	
	dk_call dk_echo
	dk_call dk_echo "Test Setting DIGITALKNOB_DIR . . ."
	dk_call dk_DIGITALKNOB_DIR "C:/DK"
	dk_call dk_printVar DIGITALKNOB_DIR 
}
