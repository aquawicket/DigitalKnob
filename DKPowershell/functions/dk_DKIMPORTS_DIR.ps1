if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_DKIMPORTS_DIR_ps1){ $dk_DKIMPORTS_DIR_ps1 = 1; } else{ return; } #include guard

####################################################################
# dk_DKIMPORTS_DIR()
#
#
function Global:dk_DKIMPORTS_DIR() {
    dk_debugFunc 0 1

	############ SET ############
	if($($args[0])){  
		${env:DKIMPORTS_DIR} = $($args[0]) 

	############ GET ############
	} else {
		if(!(${env:DKIMPORTS})){
			${env:DKIMPORTS}="_DKIMPORTS"
		}
		if(!(${env:DKIMPORTS_DIR})){
			${env:DKIMPORTS_DIR}="$(dk_call dk_DK3RDPARTY_DIR)/${env:DKIMPORTS}"
		}
	}
	
	############ FINALIZE ############
	${env:DKIMPORTS_DIR} = ${env:DKIMPORTS_DIR} -replace '\\', '/';

	#if(!(Test-Path $DKIMPORTS_DIR)){ 
	#	dk_call dk_mkdir "${DKIMPORTS_DIR}" 
	#}
	return ${env:DKIMPORTS_DIR}
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST() {
	dk_debugFunc 0;
	
	###### GET ######
	dk_call dk_echo "\n";
	dk_call dk_echo "Test Getting DKIMPORTS_DIR . . .\n";
	dk_call dk_DKIMPORTS_DIR
	dk_call dk_echo "env:DKIMPORTS_DIR = ${env:DKIMPORTS_DIR}";
    dk_call dk_echo "dk_DKIMPORTS_DIR = '$(dk_call dk_DKIMPORTS_DIR)'\n";
	
	###### SET ######
	dk_call dk_echo "\n";
	dk_call dk_echo "Test Setting DKIMPORTS_DIR . . .\n";
	dk_call dk_DKIMPORTS_DIR "C:/Users/Administrator/DigitalKnob/3rdParty/_DKIMPORTS"
	dk_call dk_echo "env:DKIMPORTS_DIR = ${env:DKIMPORTS_DIR}"
	dk_call dk_echo "dk_DKIMPORTS_DIR = '$(dk_call dk_DKIMPORTS_DIR 'C:/Users/Administrator/DigitalKnob/3rdParty/_DKIMPORTS')'\n";
}
