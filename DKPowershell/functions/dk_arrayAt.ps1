if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1 } else { . ${PSScriptRoot}/../DK.ps1 }
if(!$dk_arrayAt_ps1){ $dk_arrayAt_ps1 = 1; } else{ return; } #include guard

################################################################################
# dk_arrayAt(array, index) -> rtn_var
#
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/at
#
function Global:dk_arrayAt() {
	dk_debugFunc 2 3;
	
	$array = $args[0];
	$index = $args[1];
	if(Test-Path variable:$array){ $array = Get-Variable -Name ($array) -ValueOnly } 
	${global:dk_arrayAt} = $array[$index];

	if($args[1]) {
		Set-Variable -Name $args[1] -Value ${dk_arrayAt} -Scope Global;
	} else {
		return ${dk_arrayAt};
	}
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
function Global:DKTEST() {
	dk_debugFunc 0;
	
	$myArray = @('a', 'b', 'c', 'd', 'e');
	dk_call dk_printVar myArray;
	$arrayAt_3 = dk_call Array/dk_at myArray 3;
	dk_call dk_echo "arrayAt_3 = $arrayAt_3\n";
	$elementB = dk_call Array/dk_at $myArray 1;
	dk_call dk_echo "elementB = $elementB\n";
	
	$myArrayB = [System.Collections.ArrayList]('1', '2', '3', '4', '5');
	$elementB_A = dk_call Array/dk_at myArrayB 3;
	dk_call dk_echo "elementB_A = $elementB_A\n";
	$elementB_B = dk_call Array/dk_at $myArrayB 1;
	dk_call dk_echo "elementB_B = $elementB_B\n";
	
	$myArrayC = ('1', '2', '3', '4', '5');
	$elementC_A = dk_call Array/dk_at myArrayC 3;
	dk_call dk_echo "elementC_A = $elementC_A\n";
	$elementC_B = dk_call Array/dk_at $myArrayC 1;
	dk_call dk_echo "elementC_B = $elementC_B\n";
	
	$myArrayD = "string";
	$elementD_A = dk_call Array/dk_at myArrayD 3;
	dk_call dk_echo "elementD_A = $elementD_A\n";
	$elementD_B = dk_call Array/dk_at $myArrayD 1;
	dk_call dk_echo "elementD_B = $elementD_B\n";
	
	$myArrayE = 123456789;
	$elementE_A = dk_call Array/dk_at myArrayE 3;
	dk_call dk_echo "elementE_A = $elementE_A\n";
	$elementE_B = dk_call Array/dk_at $myArrayE 1;
	dk_call dk_echo "elementE_B = $elementE_B\n";
}