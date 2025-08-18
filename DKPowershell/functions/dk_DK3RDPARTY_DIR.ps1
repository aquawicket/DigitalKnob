if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_DK3RDPARTY_DIR_ps1){ $dk_DK3RDPARTY_DIR_ps1 = 1; } else{ return; } #include guard

###############################################################################
# dk_DK3RDPARTY_DIR()
#
#
function Global:dk_DK3RDPARTY_DIR() {
	dk_debugFunc 0 1
	
	############ SET ############
	if($($args[0])){  
		${env:DK3RDPARTY_DIR} = $($args[0]) 

	############ GET ############
	} else {
		if(!(${env:DK3RDPARTY})){
			${env:DK3RDPARTY}="3rdParty"
		}
		if(!(${env:DK3RDPARTY_DIR})){
			${env:DK3RDPARTY_DIR}="$(dk_call dk_DKBRANCH_DIR)/${env:DK3RDPARTY}"
		}
	}
	
	############ FINALIZE ############
	${env:DK3RDPARTY_DIR} = ${env:DK3RDPARTY_DIR} -replace '\\', '/';

	#if(!(Test-Path $DK3RDPARTY_DIR)){ 
	#	dk_call dk_mkdir "${DK3RDPARTY_DIR}" 
	#}
	return ${env:DK3RDPARTY_DIR}
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST() {
	dk_debugFunc 0;
	
	###### GET ######
	dk_call dk_echo "\n";
	dk_call dk_echo "Test Getting DK3RDPARTY_DIR . . .\n";
	dk_call dk_DK3RDPARTY_DIR
	dk_call dk_echo "env:DK3RDPARTY_DIR = ${env:DK3RDPARTY_DIR}";
    dk_call dk_echo "dk_DK3RDPARTY_DIR = '$(dk_call dk_DK3RDPARTY_DIR)'\n";
	
	###### SET ######
	dk_call dk_echo "\n";
	dk_call dk_echo "Test Setting DK3RDPARTY_DIR . . .\n";
	dk_call dk_DK3RDPARTY_DIR "C:/Users/Administrator/DigitalKnob/3rdParty"
	dk_call dk_echo "env:DK3RDPARTY_DIR = ${env:DK3RDPARTY_DIR}"
	dk_call dk_echo "dk_DK3RDPARTY_DIR = '$(dk_call dk_DK3RDPARTY_DIR 'C:/Users/Administrator/DigitalKnob/3rdParty')'\n";
}
