if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_unset){ $dk_unset = 1 } else{ return } #include guard

##################################################################################
# dk_unset(variable)
#
#
function Global:dk_unset($variable) {
	dk_debugFunc 1

	if(!(Test-Path variable:$variable)){ return }
	Remove-Variable $variable -Scope Global
	
	#if(!(Test-Path variable:$variable)){ return }
	#Remove-Variable $variable -Scope Local
	
	#if(!(Test-Path variable:$variable)){ return }
	#Remove-Variable $variable -Scope Script
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
function Global:DKTEST() {
	dk_debugFunc 0
	
	$global:myVar = "initial value assigned with dk_unset"
	dk_call dk_echo "myVar = ${myVar}"
	dk_call dk_unset myVar
	dk_call dk_echo "myVar = ${myVar}"
}
