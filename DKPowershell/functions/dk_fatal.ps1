if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_fatal_ps1){ $dk_fatal_ps1 = 1; } else{ return; } #include guard

################################################################################
# dk_fatal(message)
#
#    Print a fatal message to the console
#
#    @message	- The message to print
#
function Global:dk_fatal() {
	dk_debugFunc 0 1;
	
	dk_call dk_log FATAL "$($args[0])";
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### 
function Global:DKTEST() { 
	dk_debugFunc 0;	
	
	dk_call dk_fatal "test dk_fatal message";
}
