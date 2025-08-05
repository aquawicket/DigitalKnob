if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_verbose_ps1){ $dk_verbose_ps1 = 1; } else{ return; } #include guard

################################################################################
# dk_verbose(message)
#
#    Print a warning message to the console
#
#    @message	- The message to print
#
function Global:dk_verbose(){
	dk_debugFunc 0 1;
	
	dk_call dk_log VERBOSE "$($args[0])";
}












###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;
	
	dk_call dk_verbose "test dk_verbose message";
}
