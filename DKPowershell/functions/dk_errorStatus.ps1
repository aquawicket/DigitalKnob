<<<<<<< HEAD
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_errorStatus){ $dk_errorStatus = 1 } else{ return }
=======
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_errorStatus){ $dk_errorStatus = 1 } else{ return } #include guard
>>>>>>> Development

##################################################################################
# dk_errorStatus()
#
#
function Global:dk_errorStatus(){
	dk_debugFunc 0
	
	dk_call dk_echo "$(__FILE__ 1):$(__LINE__ 1) ERROR_STATUS = $?"
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_errorStatus
}