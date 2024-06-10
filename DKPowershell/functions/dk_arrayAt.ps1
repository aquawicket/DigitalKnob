if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_arrayAt){ $dk_arrayAt = 1 } else{ return }

dk_load dk_error
################################################################################
# dk_arrayAt(array, index) -> rtn_var
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_at
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/at
#
function Global:dk_arrayAt($array, $index) {
	dk_debugFunc
	if($(__ARGC__) -ne 2){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	if(Test-Path variable:$array){ $_array_ = Get-Variable -Name ($array) -ValueOnly } 
	else { $_array_ = $array }
	
	return $_array_[$index]
}




function Global:DKTEST () { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	$myArray = @('a', 'b', 'c', 'd', 'e')

	$elementA = dk_arrayAt myArray 3
	dk_echo "elementA = $elementA"
	
	$elementB = dk_arrayAt $myArray 1
	dk_echo "elementB = $elementB"
}