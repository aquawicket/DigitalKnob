if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_arrayIndexOf){ $dk_arrayIndexOf = 1 } else{ return }

################################################################################
# dk_arraySplice(array, start, deleteCount, item1, item2, /* …, */ itemN)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_splice
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/splice
#
function Global:dk_arraySplice() {
	dk_debugFunc 2


	dk_todo
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST
	dk_debugFunc 0
	

	#  TODO
	dk_arraySplice array start
}