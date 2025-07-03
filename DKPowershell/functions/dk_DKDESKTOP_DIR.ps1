if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_DKDESKTOP_DIR_ps1){ $dk_DKDESKTOP_DIR_ps1 = 1; } else{ return; } #include guard

####################################################################
# dk_DKDESKTOP_DIR()
#
#
function Global:dk_DKDESKTOP_DIR() {
    dk_debugFunc 0 1

	############ SET ############
	if($($args[0])){
		${env:DKDESKTOP_DIR} = $($args[0])
	
	############ GET ############
	} else {
		if(!(${env:DKDESKTOP})){
			${env:DKDESKTOP}="Desktop"
		}
		if(!(${env:DKDESKTOP_DIR})){
			$env:DKDESKTOP_DIR = "$(dk_call dk_DKHOME_DIR)/${env:DKDESKTOP}"
		}
	}	

	############ FINALIZE ############
	${env:DKDESKTOP_DIR} = ${env:DKDESKTOP_DIR} -replace '\\', '/';
	
	#if(!(Test-Path $DKDESKTOP_DIR)){ 
	#	dk_call dk_mkdir "${DKDESKTOP_DIR}" 
	#}
	return ${env:DKDESKTOP_DIR}
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST() {
    dk_debugFunc 0 
   
	###### GET ######
	dk_call dk_echo "\n";
	dk_call dk_echo "Test Getting DKDESKTOP_DIR . . .\n";
	dk_call dk_DKDESKTOP_DIR
	dk_call dk_echo "env:DKDESKTOP_DIR = ${env:DKDESKTOP_DIR}";
    dk_call dk_echo "dk_DKDESKTOP_DIR = '$(dk_call dk_DKDESKTOP_DIR)'\n";
	
	###### SET ######
	dk_call dk_echo "\n";
	dk_call dk_echo "Test Setting dk_DKDESKTOP_DIR . . .\n";
	dk_call dk_DKDESKTOP_DIR "C:/Desktop"
	dk_call dk_echo "env:DKDESKTOP_DIR = ${env:DKDESKTOP_DIR}"
	dk_call dk_echo "dk_DKDESKTOP_DIR = '$(dk_call dk_DKDESKTOP_DIR 'C:/Desktop')'\n";
}
