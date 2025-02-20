if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_sleep_ms){ $dk_sleep_ms = 1 } else{ return } #include guard

####################################################################
# dk_sleep_ms(milliseconds)
#
function Global:dk_sleep_ms($milliseconds) {
	dk_debugFunc 1
	
	Start-Sleep -Milliseconds $milliseconds
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
function Global:DKTEST() { 
	dk_debugFunc 0
	
	$milliseconds = 3500;
	dk_call dk_echo "sleeping for $milliseconds milliseconds"
	dk_call dk_sleep_ms $milliseconds
}
