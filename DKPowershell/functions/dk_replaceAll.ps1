if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_replaceAll){ $dk_replaceAll = 1 } else{ return }

dk_load dk_printVar
##################################################################################
# dk_replaceAll(input, searchValue, newValue) -> rtn_var
#
#
function Global:dk_replaceAll($str, $searchValue, $newValue) {
	dk_debugFunc
	if($(__ARGC__) -ne 3){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
		
	$str = $str -replace $searchValue, $newValue
	
	dk_printVar str
	return $str
}



function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	$string_var="AZC AZC Zannana Zread"
	echo "string before:  ${string_var}"
	
	$string_var = dk_replaceAll $string_var "Z" "B"
	
	echo "string after:  ${string_var}"
}