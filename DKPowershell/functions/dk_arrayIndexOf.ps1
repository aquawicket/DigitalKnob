if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_arrayIndexOf){ $dk_arrayIndexOf = 1 } else{ return } #include guard

################################################################################
# dk_arrayIndexOf(array, searchElement) -> rtn_val
# dk_arrayIndexOf(array, searchElement, fromIndex) -> rtn_val
#
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/indexOf
#
function Global:dk_arrayIndexOf($array, $searchElement) {
	dk_debugFunc 2
	
	if(Test-Path variable:$array){ $_array_ = Get-Variable -Name ($array) -ValueOnly } 
	else { $_array_ = $array }
	
	for($indexOf=0; $indexOf -le $_array_.count; $indexOf++) {
		if($searchElement -eq $_array_[$indexOf]){
			dk_call dk_printVar indexOf
			return $indexOf
		}
	}
	$indexOf = -1
	dk_call dk_printVar indexOf
	return $indexOf
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	$myArray = @('a', 'b', 'c', 'd', 'e')
	
	$indexA = dk_call dk_arrayIndexOf myArray "a" 
	dk_call dk_echo "indexA = ${indexA}"
	
	$indexB = dk_call dk_arrayIndexOf $myArray "b"
	dk_call dk_echo "indexB = ${indexB}"
	
	$indexC = dk_call dk_arrayIndexOf myArray "c" 
	dk_call dk_echo "indexC = ${indexC}"
	
	$indexD = dk_call dk_arrayIndexOf $myArray "d" indexD
	dk_call dk_echo "indexD = ${indexD}"
	
	$indexE = dk_call dk_arrayIndexOf myArray "e" 
	dk_call dk_echo "indexE = ${indexE}"
	
	$indexN = dk_call dk_arrayIndexOf $myArray "nonExistant" 
	dk_call dk_echo "indexN = ${indexN}"
}