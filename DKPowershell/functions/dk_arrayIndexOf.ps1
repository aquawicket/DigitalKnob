if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_arrayFlat){ $dk_arrayFlat = 1 } else{ return }


dk_load dk_error
################################################################################
# dk_arrayIndexOf(array, searchElement) -> rtn_val
# dk_arrayIndexOf(array, searchElement, fromIndex) -> rtn_val
#
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/indexOf
#
function Global:dk_arrayIndexOf($array, $searchElement) {
	dk_debugFunc
	if($(__ARGC__) -ne 2){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	$arry = Get-Variable -Name ($array) -ValueOnly
	for($i=0; $i -le $arry.count; $i++) {
		if($searchElement -eq $arry[$i]){
			return $i
		}
	}
	return -1
}




function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	$MyArray = @('a', 'b', 'c', 'd', 'e')
	
	$indexA = dk_arrayIndexOf MyArray "a" 
	dk_echo "indexA = ${indexA}"
	
	$indexB = dk_arrayIndexOf MyArray "b"
	dk_echo "indexB = ${indexB}"
	
	$indexC = dk_arrayIndexOf MyArray "c" 
	dk_echo "indexC = ${indexC}"
	
	$indexD = dk_arrayIndexOf MyArray "d" indexD
	dk_echo "indexD = ${indexD}"
	
	$indexE = dk_arrayIndexOf MyArray "e" 
	dk_echo "indexE = ${indexE}"
	
	$indexN = dk_arrayIndexOf MyArray "nonExistant" 
	dk_echo "indexN = ${indexN}"
}