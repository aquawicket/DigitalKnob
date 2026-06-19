if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_fixme_ps1){ $dk_fixme_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_fixme(message)
#
#	Print a fixme message to the console
#
#	@msg	- The message to print
#
function Global:dk_fixme(){
	dk_debugFunc 0 1;
	
	if(!($args[0])){
		Write-Host "";
		return;
	}
	
	dk_call dk_log FIXME "$($args[0])";
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;
	
	dk_call dk_fixme "test dk_fixme message";
}
