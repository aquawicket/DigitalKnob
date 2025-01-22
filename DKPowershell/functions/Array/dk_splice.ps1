if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$Array_dk_splice){ $Array_dk_splice = 1 } else{ return } #include guard

################################################################################
# Array:dk_splice(array, start, deleteCount, item1, item2, /* …, */ itemN)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_splice
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/splice
#
function Global:Array:dk_splice() {
	dk_debugFunc 2

	dk_call dk_todo
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST
	dk_debugFunc 0
	
	#  TODO
	dk_call Array:dk_splice array start
}
