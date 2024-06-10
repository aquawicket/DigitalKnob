if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_arrayJoin){ $dk_arrayJoin = 1 } else{ return }

################################################################################
# dk_arrayJoin(array, separator) -> rtn_var
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_join
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/join
#
function Global:dk_arrayJoin($array, $separator) {
	dk_debugFunc
	if($(__ARGC__) -ne 2){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	if(Test-Path variable:$array){ $_array_ = Get-Variable -Name ($array) -ValueOnly } 
	else { $_array_ = $array }
	
	$rtn_var = $_array_ -join $separator
	return $rtn_var
}




function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	$myArray = @('a', 'b', 'c', 'd', 'e')
	
	$myString = dk_arrayJoin myArray ","
	echo "myString = $myString"
}
