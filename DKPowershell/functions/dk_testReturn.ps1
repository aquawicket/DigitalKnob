if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_testReturn_ps1){ $dk_testReturn_ps1 = 1; } else{ return; } #include guard

################################################################################
# dk_testReturn(input, output)
#
#
function Global:dk_testReturn() {
	dk_debugFunc 1 2;

	${global:dk_testReturn} = $args[0] -replace "input", "output";
	
	if($args[1]) {
		Set-Variable -Name $args[1] -Value ${dk_testReturn} -Scope Global;
	} else {
		return ${dk_testReturn};
	}
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;
	
	### Result as global variable
	dk_call dk_echo
	dk_call dk_testReturn "inputA";
	dk_call dk_echo "dk_testReturn = ${dk_testReturn}";
	
	### Result as parameter
	dk_call dk_echo
	dk_call dk_testReturn "inputB" resultB;
	dk_call dk_echo "resultB = ${resultB}";
	dk_call dk_echo "dk_testReturn = ${dk_testReturn}";
	
	### Result as return value
	dk_call dk_echo
	$resultC = dk_call dk_testReturn "inputC";
	dk_call dk_echo "resultC = ${resultC}";
	dk_call dk_echo "dk_testReturn = ${dk_testReturn}";
}
