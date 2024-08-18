if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_toLower){ $dk_toLower = 1 } else{ return }

####################################################################
# dk_sleep(milliseconds)
#
function Global:dk_sleep($milliseconds) {
	dk_debugFunc 1
	
	Start-Sleep -m $milliseconds
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
function Global:DKTEST() { 
	dk_debugFunc 0
	
	dk_call dk_sleep 5000
}
