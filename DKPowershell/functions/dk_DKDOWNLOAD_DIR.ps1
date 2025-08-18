if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_DKDOWNLOAD_DIR_ps1){ $dk_DKDOWNLOAD_DIR_ps1 = 1; } else{ return; } #include guard

####################################################################
# dk_DKDOWNLOAD_DIR()
#
#
function Global:dk_DKDOWNLOAD_DIR() {
    dk_debugFunc 0 1

	############ SET ############
	if($($args[0])){  
		$env:DKDOWNLOAD_DIR = $($args[0])
	
	############ GET ############
	} else {
		if(!(${env:DKDOWNLOAD})){
			${env:DKDOWNLOAD}="download"
		}
		if(!(${env:DKDOWNLOAD_DIR})){
			$env:DKDOWNLOAD_DIR = "$(dk_call dk_DIGITALKNOB_DIR)/${env:DKDOWNLOAD}"
		}
	}
	
	############ FINALIZE ############
	${env:DKDOWNLOAD_DIR} = ${env:DKDOWNLOAD_DIR} -replace '\\', '/';
	
	#if(!(Test-Path $DKDOWNLOAD_DIR)){ 
	#	dk_call dk_mkdir "${DKDOWNLOAD_DIR}" 
	#}
	return ${env:DKDOWNLOAD_DIR}
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST() {
    dk_debugFunc 0 
   
	###### GET ######
	dk_call dk_echo "\n";
	dk_call dk_echo "Test Getting DKDOWNLOAD_DIR . . .\n";
	dk_call dk_DKDOWNLOAD_DIR
	dk_call dk_echo "env:DKDOWNLOAD_DIR = ${env:DKDOWNLOAD_DIR}";
    dk_call dk_echo "dk_DKDOWNLOAD_DIR = '$(dk_call dk_DKDOWNLOAD_DIR)'\n";
	
	###### SET ######
	dk_call dk_echo "\n";
	dk_call dk_echo "Test Setting dk_DKDOWNLOAD_DIR . . .\n";
	dk_call dk_DKDOWNLOAD_DIR "C:/Users/Administrator/DigitalKnob/download"
	dk_call dk_echo "env:DKDOWNLOAD_DIR = ${env:DKDOWNLOAD_DIR}"
	dk_call dk_echo "dk_DKDOWNLOAD_DIR = '$(dk_call dk_DKDOWNLOAD_DIR 'C:/Users/Administrator/DigitalKnob/download')'\n";
}
