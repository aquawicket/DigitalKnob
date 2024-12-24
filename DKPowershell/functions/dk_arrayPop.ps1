if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!${$PSCommandPath}){ ${$PSCommandPath} = 1 } else{ return } #include guard

################################################################################
# dk_arrayPop(array)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_pop
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/pop
#
function Global:dk_arrayPop($array) {
	dk_debugFunc 1

	#if($array -isnot [System.Object]){ dk_call dk_error "Not a System.Object"; return ${false} }
	if($array.count -eq 0){ $arrayPop = "undefined"; dk_call dk_printVar arrayPop; return $arrayPop }
	if(Test-Path variable:$array){ $array = Get-Variable -Name ($array) -ValueOnly }
	if($array -isnot [System.Collections.ArrayList]){ dk_call dk_error "array is not an ArrayList"; return ${false} }	
	if($array.count -eq 0){ $arrayPop = "undefined"; dk_call dk_printVar arrayPop; return $arrayPop }
	
	$arrayPop = $array[$array.count-1]
	$array.removeAt($array.count-1)
	dk_call dk_printVar arrayPop
	return $arrayPop
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	$myArray = [System.Collections.ArrayList]('a', 'b', 'c')
	dk_call dk_arrayPop $myArray
	dk_call dk_echo "myArray = $myArray"
	
	$myArrayB = [System.Collections.ArrayList]('1', '2', '3')
	dk_call dk_arrayPop $myArrayB
	dk_call dk_echo "myArrayB = $myArrayB"
}
