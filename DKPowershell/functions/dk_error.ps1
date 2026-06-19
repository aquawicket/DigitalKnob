if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_error_ps1){ $dk_error_ps1 = 1; } else{ return; } #include guard

################################################################################
# dk_error(message)
#
#    Print a error message to the console
#
#    @message	- The message to print
#
function Global:dk_error() {
	dk_debugFunc 0 1;
	
	if(!($args[0])){
		Write-Host "";
		return;
	}
	
	dk_call dk_log ERROR "$($args[0])";
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### 
function Global:DKTEST() { 
	dk_debugFunc 0;
	
	dk_call dk_error "test dk_error message";
	dk_call dk_error; 
	dk_call dk_error "test dk_error new line";
}
