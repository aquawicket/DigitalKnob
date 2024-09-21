if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_set){ $dk_set = 1 } else{ return }

##################################################################################
# dk_set(variable value)
#
#
function Global:dk_set($variable, $value) {
	dk_debugFunc 2

	Set-Variable -Name $variable -Value $value -Scope Global
	dk_call dk_printVar $variable
}















###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_set myVar "value assigned with dk_set"	
	dk_call dk_info "myVar = ${myVar}"
}
