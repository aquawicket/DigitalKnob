if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_warning_ps1){ $dk_warning_ps1 = 1; } else{ return; } #include guard

################################################################################
# dk_warning(message)
#
#    Print a warning message to the console
#
#    @message	- The message to print
#
function Global:dk_warning(){
	dk_debugFunc 0 1;
	
	dk_call dk_log WARNING "$($args[0])";
}














###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;
	
	dk_call dk_warning "test dk_warning message";
}
