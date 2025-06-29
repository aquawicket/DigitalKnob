if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_sleep_ps1){ $dk_sleep_ps1 = 1; } else{ return; } #include guard

####################################################################
# dk_sleep(seconds)
#
function Global:dk_sleep($seconds) {
	dk_debugFunc 1;
	
	Start-Sleep -Seconds $seconds
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
function Global:DKTEST() { 
	dk_debugFunc 0;
	
	$seconds = 5;
	dk_call dk_echo "sleeping for $seconds seconds"
	dk_call dk_sleep $seconds
}
