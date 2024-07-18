if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_arrayPush){ $dk_arrayPush = 1 } else{ return }

################################################################################
# dk_arrayPush(array, element1, element2, /* …, */ elementN) -> rtn_var
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_push
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/push
#
function Global:dk_arrayPush($array, $element1) {
	dk_debugFunc
	if($(__ARGC__) -ne 2){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	
	#if($array -isnot [System.Object]){ dk_error "Not a System.Object"; return ${false} }
	#if($array.count -eq 0){ $removed_element = "undefined"; dk_printVar removed_element; return $removed_element }
	if(Test-Path variable:$array){ $array = Get-Variable -Name ($array) -ValueOnly }
	if($array -isnot [System.Collections.ArrayList]){ dk_error "array is not an ArrayList"; return ${false} }	
	#if($array.count -eq 0){ $removed_element = "undefined"; dk_printVar removed_element; return $removed_element }
	
	$array.Add($element1)
	
	$arrayPush = $array.count
	dk_printVar arrayPush
	return $arrayPush
}




function Global:DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc
	
	
	#$myArray = [System.Collections.ArrayList]('a', 'b', 'c', 'd', 'e')
	#dk_printVar myArray
	
	$myArray = [System.Collections.ArrayList]('1', '2', '3')
	
	dk_arrayPush myArray a
	dk_printVar myArray
	
	dk_arrayPush myArray b
	dk_printVar myArray
	
	dk_arrayPush myArray c
	dk_printVar myArray
	
	dk_arrayPush myArray d
	dk_printVar myArray
}