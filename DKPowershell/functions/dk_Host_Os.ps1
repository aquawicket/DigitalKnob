if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_Host_Os_ps1){ $dk_Host_Os_ps1 = 1; } else{ return; } #include guard


################################################################################
# dk_Host_Os()
#
#    Function description
#
#    @arg1	- arg1 description
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
	
	${global:$(Host_Os)_Host} = 1;
	${env:$(Host_Os)_Host} = 1;

}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;

	###### GET ######
    dk_call dk_Host_Os
	dk_call dk_echo
	dk_call dk_echo "Host_Os = ${Host_Os}"
	dk_call dk_echo "env:Host_Os = ${env:Host_Os}"
	dk_call dk_echo "${Host_Os}_Host = ${$(Host_Os)_Host}"
	dk_call dk_echo "env:${Host_Os}_Host = ${env:$(Host_Os)_Host}"
	
	###### SET ######
	dk_call dk_Host_Os "Linux"
	dk_call dk_echo
	dk_call dk_echo "Host_Os = ${Host_Os}"
	dk_call dk_echo "env:Host_Os = ${env:Host_Os}"
	dk_call dk_echo "${Host_Os}_Host = ${$(Host_Os)_Host}"
	dk_call dk_echo "env:${Host_Os}_Host = ${env:$(Host_Os)_Host}"
}
