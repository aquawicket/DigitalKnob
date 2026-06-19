if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_beep_ps1){ $dk_beep_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_beep(frequency, duration)
#
#
function Global:dk_beep(){
	dk_debugFunc 0;
	
	[console]::beep(500,300)
} 


###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;
	
	dk_call dk_beep
}
