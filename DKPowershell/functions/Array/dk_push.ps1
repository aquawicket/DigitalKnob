if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$Array_dk_push){ $Array_dk_push = 1 } else{ return } #include guard

################################################################################
# Array:dk_push(array, element1, element2, /* …, */ elementN) -> rtn_var
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_push
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/push
#
function Global:Array:dk_push($array, $element1) {
	dk_debugFunc 2

	#if($array -isnot [System.Object]){ dk_call dk_error "Not a System.Object"; return ${false} }
	#if($array.count -eq 0){ $removed_element = "undefined"; dk_call dk_printVar removed_element; return $removed_element }
	if(Test-Path variable:$array){ $array = Get-Variable -Name ($array) -ValueOnly }
	if($array -isnot [System.Collections.ArrayList]){ dk_call dk_error "array is not an ArrayList"; return ${false} }	
	#if($array.count -eq 0){ $removed_element = "undefined"; dk_call dk_printVar removed_element; return $removed_element }
	
	$array.Add($element1)
	
	$arrayPush = $array.count
	dk_call dk_printVar arrayPush
	return $arrayPush
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	#$myArray = [System.Collections.ArrayList]('a', 'b', 'c', 'd', 'e')
	#dk_call dk_printVar myArray
	
	$myArray = [System.Collections.ArrayList]('1', '2', '3')
	
	dk_call Array:dk_push myArray a
	dk_call dk_printVar myArray
	
	dk_call Array:dk_push myArray b
	dk_call dk_printVar myArray
	
	dk_call Array:dk_push myArray c
	dk_call dk_printVar myArray
	
	dk_call Array:dk_push myArray d
	dk_call dk_printVar myArray
}