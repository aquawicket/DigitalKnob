if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_arrayPop){ $dk_arrayPop = 1 } else{ return }

dk_load dk_printArray
dk_load dk_arrayLength
dk_load dk_unset
################################################################################
# dk_arrayPop(array)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_pop
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/pop
#
function Global:dk_arrayPop($array) {
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	if(Test-Path variable:$array){ $_array_ = Get-Variable -Name ($array) -ValueOnly } 
	else { $_array_ = $array }

	if($_array_.count -eq 0){ return }
	$_array_.removeAt($_array_.count-1)
}




function Global:DKTEST () { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	$myArray = [System.Collections.ArrayList]('a', 'b', 'c', 'd', 'e')
	dk_printArray myArray
	
	dk_arrayPop $myArray
	dk_printArray myArray
	
	dk_arrayPop myArray
	dk_printArray myArray
	
	dk_arrayPop $myArray
	dk_printArray myArray
	
	dk_arrayPop myArray
	dk_printArray myArray
	
	dk_arrayPop $myArray
	dk_printArray myArray
	
	dk_arrayPop myArray
	dk_printArray myArray
	
	dk_arrayPop $myArray
	dk_printArray myArray
	
	dk_arrayPop myArray
	dk_printArray myArray	
}
