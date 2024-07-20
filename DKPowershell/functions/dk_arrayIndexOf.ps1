if(!$DKINIT){ .${env:DKPOWERSHELL_FUNCTIONS_DIR}\DK.ps1 }
if(!$dk_arrayIndexOf){ $dk_arrayIndexOf = 1 } else{ return }

################################################################################
# dk_arrayIndexOf(array, searchElement) -> rtn_val
# dk_arrayIndexOf(array, searchElement, fromIndex) -> rtn_val
#
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/indexOf
#
function Global:dk_arrayIndexOf($array, $searchElement) {
	dk_debugFunc
	if($(__ARGC__) -ne 2){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	
	if(Test-Path variable:$array){ $_array_ = Get-Variable -Name ($array) -ValueOnly } 
	else { $_array_ = $array }
	
	for($indexOf=0; $indexOf -le $_array_.count; $indexOf++) {
		if($searchElement -eq $_array_[$indexOf]){
			dk_printVar indexOf
			return $indexOf
		}
	}
	$indexOf = -1
	dk_printVar indexOf
	return $indexOf
}




function Global:DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc
	
	
	$myArray = @('a', 'b', 'c', 'd', 'e')
	
	$indexA = dk_arrayIndexOf myArray "a" 
	dk_echo "indexA = ${indexA}"
	
	$indexB = dk_arrayIndexOf $myArray "b"
	dk_echo "indexB = ${indexB}"
	
	$indexC = dk_arrayIndexOf myArray "c" 
	dk_echo "indexC = ${indexC}"
	
	$indexD = dk_arrayIndexOf $myArray "d" indexD
	dk_echo "indexD = ${indexD}"
	
	$indexE = dk_arrayIndexOf myArray "e" 
	dk_echo "indexE = ${indexE}"
	
	$indexN = dk_arrayIndexOf $myArray "nonExistant" 
	dk_echo "indexN = ${indexN}"
}