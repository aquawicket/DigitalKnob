if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_arrayLength_ps1){ $dk_arrayLength_ps1 = 1; } else{ return; } #include guard

################################################################################
# dk_arrayLength(array, rtnvar)
#
#    reference: https://www.w3schools.com/js/js_array_methods.asp#mark_length
#
function Global:dk_arrayLength() {
	dk_debugFunc 1 2;
	
	$array = $args[0];
	if(Test-Path variable:$array){ 
		$array = Get-Variable -Name ($array) -ValueOnly -ErrorAction SilentlyContinue;
	} 
	${global:dk_arrayLength} = $array.count;
 
	if($args[1]) {
		Set-Variable -Name $args[1] -Value ${dk_arrayLength} -Scope Global;
	} else {
		return ${dk_arrayLength};
	}
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;
	
	### Result as global variable
	$myArrayA = @();
	dk_call dk_echo;
	dk_call dk_arrayLength myArrayA;
	dk_call dk_echo "dk_arrayLength = ${dk_arrayLength}";
	
	### Result as parameter
	$myArrayB = @('element 1');
	dk_call dk_echo;
	dk_call dk_arrayLength myArrayB lengthB;
	dk_call dk_echo "lengthB = ${lengthB}";
	dk_call dk_echo "dk_arrayLength = ${dk_arrayLength}";
	
	### Result as return value
	$myArrayC = @('element 1', 'element 2');
	dk_call dk_echo;
	$lengthC = dk_call dk_arrayLength myArrayC;
	dk_call dk_echo "lengthC = ${lengthC}";
	dk_call dk_echo "dk_arrayLength = ${dk_arrayLength}";
}