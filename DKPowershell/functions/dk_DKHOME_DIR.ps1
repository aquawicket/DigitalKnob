if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_DKHOME_DIR_ps1){ $dk_DKHOME_DIR_ps1 = 1; } else{ return; } #include guard

####################################################################
# dk_DKHOME_DIR()
#
#
function Global:dk_DKHOME_DIR() {
	dk_debugFunc 0 1

	############ SET ############
	if($($args[0])){  
		${env:DKHOME_DIR} = $($args[0]);
	
	############ GET ############
	} else {
		if(!(${env:DKHOME_DIR})){
			${env:DKHOME_DIR} = ${env:USERPROFILE};
		}
	}
	
	############ FINALIZE ############
	${env:DKHOME_DIR} = ${env:DKHOME_DIR} -replace '\\', '/';
	
	dk_call dk_assertPath ${env:DKHOME_DIR}
	return ${env:DKHOME_DIR}
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;
	
	###### GET ######
	dk_call dk_echo "\n";
	dk_call dk_echo "Test Getting DKHOME_DIR . . .\n";
	dk_call dk_DKHOME_DIR
	dk_call dk_echo "env:DKHOME_DIR = ${env:DKHOME_DIR}";
    dk_call dk_echo "dk_DKHOME_DIR = '$(dk_call dk_DKHOME_DIR)'\n";
	
	###### SET ######
	dk_call dk_echo "\n";
	dk_call dk_echo "Test Getting DKHOME_DIR . . .\n";
	dk_call dk_DKHOME_DIR "C:/"
	dk_call dk_echo "env:DKHOME_DIR = ${env:DKHOME_DIR}"
	dk_call dk_echo "dk_DKHOME_DIR = '$(dk_call dk_DKHOME_DIR 'C:/')'\n";
}
