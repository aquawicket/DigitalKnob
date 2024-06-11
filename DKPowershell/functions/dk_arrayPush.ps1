if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_arrayPop){ $dk_arrayPop = 1 } else{ return }

dk_load dk_fixme
dk_fixme


dk_load dk_printArray
################################################################################
# dk_arrayPush(array, element1, element2, /* …, */ elementN)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_push
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/push
#
function Global:dk_arrayPush($array, $element1) {
	dk_debugFunc
	if($(__ARGC__) -ne 2){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	if(Test-Path variable:$array){ $_array_ = Get-Variable -Name ($array) -ValueOnly } 
	else { $_array_ = $array }	
	$end_index = $_array_.count
	##$array[${end_index}] = $element1
}




function Global:DKTEST () { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	$myArray = [System.Collections.ArrayList]('a', 'b', 'c', 'd', 'e')
	dk_printArray myArray
	
	dk_arrayPush myArray a
	dk_printArray myArray
	
	dk_arrayPush myArray b
	dk_printArray myArray
	
	dk_arrayPush myArray c
	dk_printArray myArray
	
	dk_arrayPush myArray d
	dk_printArray myArray
}