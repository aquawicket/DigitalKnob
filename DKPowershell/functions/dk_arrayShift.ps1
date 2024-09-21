if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_arrayShift){ $dk_arrayShift = 1 } else{ return }

################################################################################
# dk_arrayShift(array)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_shift
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/shift
#
function Global:dk_arrayShift($array) {
	dk_debugFunc 1

	$prev = 0
	$count = 1
	
	dk_call dk_todo
#	:dk_arrayShift_loop
#	if defined $_arry_[$count] (
#		"$_arry_[$prev]=$_arry_[$count]"
#		count+=1
#		prev+=1
#		goto:dk_arrayShift_loop
#	)
#	dk_unset $_arry_[$prev]
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	$myArray = [System.Collections.ArrayList]('a', 'b', 'c', 'd', 'e')
	
	dk_call dk_printVar myArray
	
	dk_call dk_arrayShift myArray
	dk_call dk_printVar myArray
	
	dk_call dk_arrayShift myArray
	dk_call dk_printVar myArray
	
	dk_call dk_arrayShift myArray
	dk_call dk_printVar myArray
	
	dk_call dk_arrayShift myArray
	dk_call dk_printVar myArray
	
	dk_call dk_arrayShift myArray
	dk_call dk_printVar myArray
	
	dk_call dk_arrayShift myArray
	dk_call dk_printVar myArray
}
