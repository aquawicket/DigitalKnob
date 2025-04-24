<<<<<<< HEAD
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_toLower){ $dk_toLower = 1 } else{ return }

####################################################################
# dk_sleep(milliseconds)
#
function Global:dk_sleep($milliseconds) {
	dk_debugFunc 1
	
	Start-Sleep -m $milliseconds
=======
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_sleep){ $dk_sleep = 1 } else{ return } #include guard

####################################################################
# dk_sleep(seconds)
#
function Global:dk_sleep($seconds) {
	dk_debugFunc 1
	
	Start-Sleep -Seconds $seconds
>>>>>>> Development
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
function Global:DKTEST() { 
	dk_debugFunc 0
	
<<<<<<< HEAD
	dk_call dk_sleep 5000
=======
	$seconds = 5;
	dk_call dk_echo "sleeping for $seconds seconds"
	dk_call dk_sleep $seconds
>>>>>>> Development
}
