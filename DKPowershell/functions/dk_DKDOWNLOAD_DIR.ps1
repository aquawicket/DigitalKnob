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
		$env:DKDOWNLOAD_DIR = "$($args[0])" 
	
	############ GET ############
	} else {
		dk_call dk_validate DIGITALKNOB_DIR "dk_call dk_DIGITALKNOB_DIR" 
		${env:DKDOWNLOAD_DIR} = "${env:DIGITALKNOB_DIR}/download" 
		
		if(!(Test-Path $DKDOWNLOAD_DIR)){ 
			dk_call dk_mkdir "${DKDOWNLOAD_DIR}" 
		}
	}
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST() {
    dk_debugFunc 0 
   
	dk_call dk_echo "\n";
	dk_call dk_echo "Test Getting DKDOWNLOAD_DIR . . .\n";
    dk_call dk_echo "DKDOWNLOAD_DIR = $(dk_DKDOWNLOAD_DIR)\n";
	
	dk_call dk_echo "\n";
	dk_call dk_echo "Test Setting DKDOWNLOAD_DIR . . .\n";
	dk_call dk_echo "DKDOWNLOAD_DIR = $(dk_DKDOWNLOAD_DIR 'C:/DK/download')\n";
}
