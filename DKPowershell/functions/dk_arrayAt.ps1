if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_arrayAt){ $dk_arrayAt = 1 } else{ return }

################################################################################
# dk_arrayAt(array, index) -> rtn_var
#
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/at
#
function Global:dk_arrayAt($array, $index) {
	dk_debugFunc
	if($(__ARGC__) -ne 2){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	
	if(Test-Path variable:$array){ $_array_ = Get-Variable -Name ($array) -ValueOnly } 
	else { $_array_ = $array }
	
	$arrayAt = $_array_[$index]
	dk_printVar arrayAt
	return $arrayAt
}




function Global:DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc
	
	
	$myArray = @('a', 'b', 'c', 'd', 'e')
	dk_printVar myArray
	$arrayAt_3 = dk_arrayAt myArray 3
	dk_echo "arrayAt_3 = $arrayAt_3"
	$elementB = dk_arrayAt $myArray 1
	dk_echo "elementB = $elementB"
	
	$myArrayB = [System.Collections.ArrayList]('1', '2', '3', '4', '5')
	$elementB_A = dk_arrayAt myArrayB 3
	dk_echo "elementB_A = $elementB_A"
	$elementB_B = dk_arrayAt $myArrayB 1
	dk_echo "elementB_B = $elementB_B"
	
	$myArrayC = ('1', '2', '3', '4', '5')
	$elementC_A = dk_arrayAt myArrayC 3
	dk_echo "elementC_A = $elementC_A"
	$elementC_B = dk_arrayAt $myArrayC 1
	dk_echo "elementC_B = $elementC_B"
	
	$myArrayD = "string"
	$elementD_A = dk_arrayAt myArrayD 3
	dk_echo "elementD_A = $elementD_A"
	$elementD_B = dk_arrayAt $myArrayD 1
	dk_echo "elementD_B = $elementD_B"
	
	$myArrayE = 123456789
	$elementE_A = dk_arrayAt myArrayE 3
	dk_echo "elementE_A = $elementE_A"
	$elementE_B = dk_arrayAt $myArrayE 1
	dk_echo "elementE_B = $elementE_B"
}