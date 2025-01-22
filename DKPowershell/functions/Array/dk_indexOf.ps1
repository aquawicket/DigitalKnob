if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$Array_dk_indexOf){ $Array_dk_indexOf = 1 } else{ return } #include guard

################################################################################
# Array:dk_indexOf(array, searchElement) -> rtn_val
# Array:dk_indexOf(array, searchElement, fromIndex) -> rtn_val
#
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/indexOf
#
function Global:Array:dk_indexOf($array, $searchElement) {
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
	
	$indexA = dk_call Array:dk_indexOf myArray "a" 
	dk_call dk_echo "indexA = ${indexA}"
	
	$indexB = dk_call Array:dk_indexOf $myArray "b"
	dk_call dk_echo "indexB = ${indexB}"
	
	$indexC = dk_call Array:dk_indexOf myArray "c" 
	dk_call dk_echo "indexC = ${indexC}"
	
	$indexD = dk_call Array:dk_indexOf $myArray "d" indexD
	dk_call dk_echo "indexD = ${indexD}"
	
	$indexE = dk_call Array:dk_indexOf myArray "e" 
	dk_call dk_echo "indexE = ${indexE}"
	
	$indexN = dk_call Array:dk_indexOf $myArray "nonExistant" 
	dk_call dk_echo "indexN = ${indexN}"
}