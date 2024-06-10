if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_arrayAt){ $dk_arrayAt = 1 } else{ return }

dk_load dk_error
################################################################################
# dk_arrayAt(array, index) -> rtn_var
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_at
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/at
#
function Global:dk_arrayAt($arry, $index) {
	dk_debugFunc
	if($(__ARGC__) -ne 2){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	$value = Get-Variable -Name ($arry) -ValueOnly
	return $value[$index]
}




function Global:DKTEST () { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	$myArray = @('a', 'b', 'c', 'd', 'e')

	$element = dk_arrayAt myArray 3
	dk_echo "element = $element"
}