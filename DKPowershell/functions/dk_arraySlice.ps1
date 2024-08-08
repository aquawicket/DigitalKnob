if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_arraySlice){ $dk_arraySlice = 1 } else{ return }

################################################################################
# dk_arraySlice(array, start, end)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_slice
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/slice
#
function Global:dk_arraySlice($array, $start, $end) {
	dk_debugFunc 3

	dk_todo
}




function Global:DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc
	
	dk_arraySlice array start end_
}