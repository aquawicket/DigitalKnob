if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$Array_dk_at){ $Array_dk_at = 1 } else{ return } #include guard

################################################################################
# Array:dk_at(array, index) -> rtn_var
#
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/at
#
function Global:Array:dk_at($array, $index) {
	dk_debugFunc 2
	
	
	if(Test-Path variable:$array){ $_array_ = Get-Variable -Name ($array) -ValueOnly } 
	else { $_array_ = $array }
	
	$arrayAt = $_array_[$index]
	dk_call dk_printVar arrayAt
	return $arrayAt
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
function Global:DKTEST() {
	dk_debugFunc 0
	
	
	$myArray = @('a', 'b', 'c', 'd', 'e')
	dk_call dk_printVar myArray
	$arrayAt_3 = dk_call Array:dk_at myArray 3
	dk_call dk_echo "arrayAt_3 = $arrayAt_3"
	$elementB = dk_call Array:dk_at $myArray 1
	dk_call dk_echo "elementB = $elementB"
	
	$myArrayB = [System.Collections.ArrayList]('1', '2', '3', '4', '5')
	$elementB_A = dk_call Array:dk_at myArrayB 3
	dk_call dk_echo "elementB_A = $elementB_A"
	$elementB_B = dk_call Array:dk_at $myArrayB 1
	dk_call dk_echo "elementB_B = $elementB_B"
	
	$myArrayC = ('1', '2', '3', '4', '5')
	$elementC_A = dk_call Array:dk_at myArrayC 3
	dk_call dk_echo "elementC_A = $elementC_A"
	$elementC_B = dk_call Array:dk_at $myArrayC 1
	dk_call dk_echo "elementC_B = $elementC_B"
	
	$myArrayD = "string"
	$elementD_A = dk_call Array:dk_at myArrayD 3
	dk_call dk_echo "elementD_A = $elementD_A"
	$elementD_B = dk_call Array:dk_at $myArrayD 1
	dk_call dk_echo "elementD_B = $elementD_B"
	
	$myArrayE = 123456789
	$elementE_A = dk_call Array:dk_at myArrayE 3
	dk_call dk_echo "elementE_A = $elementE_A"
	$elementE_B = dk_call Array:dk_at $myArrayE 1
	dk_call dk_echo "elementE_B = $elementE_B"
}