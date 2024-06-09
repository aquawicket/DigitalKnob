if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$dk_getExtension){ $dk_getExtension = 1 } else{ return }


##################################################################################
# dk_replaceAll(input, searchValue, newValue) -> rtn_var
#
#
function Global:dk_replaceAll($input, $searchValue, $newValue) {
	dk_debugFunc
	if($(__ARGC__) -ne 3){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
		
    $output = $input.Replace($searchValue, $newValue)
	
	dk_printVar output
	return $output
}



function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	$string_var="AZC AZC Zannana Zread"
	echo "string before:  ${string_var}"
	
	$string_var = dk_replaceAll "${string_var}" "Z" "B"
	
	echo "string after:  ${string_var}"
	pause
}