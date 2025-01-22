if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$Array_dk_slice){ $Array_dk_slice = 1 } else{ return } #include guard

################################################################################
# Array:dk_slice(array, start, end)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_slice
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/slice
#
function Global:Array:dk_slice($array, $start, $end) {
	dk_debugFunc 3

	dk_call dk_todo
}









###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST 
	dk_debugFunc 0
	
	dk_call Array:dk_slice array start end_
}
