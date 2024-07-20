if(!$DKINIT){ .${env:DKPOWERSHELL_FUNCTIONS_DIR}\DK.ps1 }
if(!$dk_replaceAll){ $dk_replaceAll = 1 } else{ return }

##################################################################################
# dk_replaceAll(input, searchValue, newValue) -> rtn_var
#
#
function Global:dk_replaceAll($str, $searchValue, $newValue) {
	dk_debugFunc
	if($(__ARGC__) -ne 3){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	
	$replaceAll = $str -replace $searchValue, $newValue
	
	dk_printVar replaceAll
	return $replaceAll
}



function Global:DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc
	
	
	$string_var="AZC AZC Zannana Zread"
	dk_info "string before:  ${string_var}"
	
	$string_var = dk_replaceAll $string_var "Z" "B"
	dk_info "string after:  ${string_var}"
}