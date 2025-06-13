if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$DKHOME_DIR){ $DKHOME_DIR = 1 } else{ return } #include guard

####################################################################
# DKHOME_DIR()
#
#
function Global:DKHOME_DIR() {
	dk_debugFunc 0 1

	############ SET ############
	if($($args[0])){  
		${env:DKHOME_DIR} = $($args[0])

	############ GET ############
	} else {
		${env:DKHOME_DIR} = ${env:USERPROFILE} -replace '\\', '/';
	}

	return ${env:DKHOME_DIR}
	#dk_call dk_assertPath DKHOME_DIR
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0
	
	dk_call dk_echo;
	dk_call dk_echo "Test Getting DKHOME_DIR . . .";
    dk_call dk_echo "DKHOME_DIR = $(DKHOME_DIR)";
	
	dk_call dk_echo;
	dk_call dk_echo "Test Setting DKHOME_DIR . . .";
	dk_call dk_echo "DKHOME_DIR = $(DKHOME_DIR 'C:/')";
}
