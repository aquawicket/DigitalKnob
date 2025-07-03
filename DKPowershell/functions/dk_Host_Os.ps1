if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_Host_Os_ps1){ $dk_Host_Os_ps1 = 1; } else{ return; } #include guard


################################################################################
# dk_Host_Os()
#
#    Get or Set the Operating System of the Host System
#
function Global:dk_Host_Os() {
	dk_debugFunc 0 99;

	###### SET ######
	if($($args[0])){
		${global:Host_Os} = $($args[0]);
		${env:Host_Os} = $($args[0]);
	
	###### GET ######	
	} else {
		${global:Host_Os} = "Windows";	
		${env:Host_Os} = "Windows";
	}
	
	###### FINALIZE ######
	${global:$(Host_Os)_Host} = 1;
	${env:$(Host_Os)_Host} = 1;

	return ${env:Host_Os}
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;

	###### GET ######
	dk_call dk_echo
	dk_call dk_echo "Test Getting Host_Os . . .\n";
	dk_call dk_Host_Os
	dk_call dk_echo "Host_Os = ${Host_Os}"
	dk_call dk_echo "env:Host_Os = ${env:Host_Os}"
	dk_call dk_echo "${Host_Os}_Host = ${$(Host_Os)_Host}"
	dk_call dk_echo "env:${Host_Os}_Host = ${env:$(Host_Os)_Host}"
	dk_call dk_echo "dk_Host_Os = '$(dk_call dk_Host_Os)'\n";
	
	###### SET ######
	dk_call dk_echo
	dk_call dk_echo "Test Setting Host_Os . . .\n";
	dk_call dk_Host_Os "Linux"
	dk_call dk_echo "Host_Os = ${Host_Os}"
	dk_call dk_echo "env:Host_Os = ${env:Host_Os}"
	dk_call dk_echo "${Host_Os}_Host = ${$(Host_Os)_Host}"
	dk_call dk_echo "env:${Host_Os}_Host = ${env:$(Host_Os)_Host}"
	dk_call dk_echo "dk_Host_Os = '$(dk_call dk_Host_Os Linux)'\n";
}
