if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_getcwd_ps1){ $dk_getcwd_ps1 = 1; } else{ return; } #include guard


################################################################################
# dk_getcwd()
#
#    Get the working directory
#
#
function Global:dk_getcwd() {
	dk_debugFunc 0;

	${PWD} = $(get-location) -replace "\\", "/";
	return ${PWD}; 
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;
	
	${PWD} = dk_call dk_getcwd;
	dk_call dk_echo "Current Directory = ${PWD}\n";
}
