if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_arrayFlat){ $dk_arrayFlat = 1 } else{ return }

################################################################################
# dk_arrayFlat(array, depth)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_flat
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/flat
#
function Global:dk_arrayFlat($array, $depth) {
	dk_debugFunc 2

	
	if(Test-Path variable:$array){ $_array_ = Get-Variable -Name ($array) -ValueOnly } 
	else { $_array_ = $array }
	
	dk_todo
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	
	dk_arrayFlat array depth
}