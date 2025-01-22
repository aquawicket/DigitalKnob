if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$Array_dk_flat){ $Array_dk_flat = 1 } else{ return } #include guard

################################################################################
# Array:dk_flat(array, depth)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_flat
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/flat
#
function Global:Array:dk_flat($array, $depth) {
	dk_debugFunc 2

	if(Test-Path variable:$array){ $_array_ = Get-Variable -Name ($array) -ValueOnly } 
	else { $_array_ = $array }
	
	dk_call dk_todo
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call Array:dk_flat array depth
}
