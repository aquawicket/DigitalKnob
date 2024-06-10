if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_arrayIndexOf){ $dk_arrayIndexOf = 1 } else{ return }

################################################################################
# dk_arrayJoin(array, separator) -> rtn_var
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_join
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/join
#
function Global:dk_arrayJoin($array, $separator) {
	dk_debugFunc
	if($(__ARGC__) -ne 2){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	$arry = Get-Variable -Name ($array) -ValueOnly
	$_string_ = $arry -join $separator
	return $_string_
}




function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	$MyArray = @('a', 'b', 'c', 'd', 'e')
	
	$string = dk_arrayJoin MyArray ","
	echo "string = $string"
}
