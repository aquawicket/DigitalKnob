if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_notice_ps1){ $dk_notice_ps1 = 1; } else{ return; } #include guard

################################################################################
# dk_notice(message)
#
#    Print a notice message to the console
#
#    @message	- The message to print
#
function Global:dk_notice(){
	dk_debugFunc 0 1;
	
	if(!($args[0])){
		Write-Host "";
		return;
	}
	
	dk_call dk_log NOTICE "$($args[0])";
}














###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;
	
	dk_call dk_notice "test dk_notice message";
}
