if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_testError_ps1){ $dk_testError_ps1 = 1; } else{ return; } #include guard


####################################################################
# dk_testError()
#
#
function Global:dk_testError() {
	#dk_debugFunc 0 1
	
	SYNTAX ERROR
	echo "LASTEXITCODE = ${LASTEXITCODE}"
	
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	#dk_debugFunc 0;
	
	dk_call dk_testError;
}
