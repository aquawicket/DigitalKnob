if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_arrayShift){ $dk_arrayShift = 1 } else{ return }

################################################################################
# dk_arrayShift(array)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_shift
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/shift
#
function Global:dk_arrayShift($array) {
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	
	$prev = 0
	$count = 1
	
	dk_todo
#	:dk_arrayShift_loop
#	if defined $_arry_[$count] (
#		"$_arry_[$prev]=$_arry_[$count]"
#		count+=1
#		prev+=1
#		goto:dk_arrayShift_loop
#	)
#	dk_unset $_arry_[$prev]
}




function Global:DKTEST () { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	$myArray = [System.Collections.ArrayList]('a', 'b', 'c', 'd', 'e')
	
	
	dk_printArray myArray
	
	dk_arrayShift myArray
	dk_printArray myArray
	
	dk_arrayShift myArray
	dk_printArray myArray
	
	dk_arrayShift myArray
	dk_printArray myArray
	
	dk_arrayShift myArray
	dk_printArray myArray
	
	dk_arrayShift myArray
	dk_printArray myArray
	
	dk_arrayShift myArray
	dk_printArray myArray
}
