if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_toUpper_ps1){ $dk_toUpper_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_toUpper(str, rtnvar)
#
#
function Global:dk_toUpper() {
	dk_debugFunc 1 2;

	$str = $args[0];
	${global:dk_toUpper} = ${str}.ToUpper();

	if($args[1]) {
		Set-Variable -Name $args[1] -Value ${dk_toUpper} -Scope Global;
	} else {
		return ${dk_toUpper};
	}
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;
	
	### Result as global variable
	dk_call dk_echo
	dk_call dk_toUpper "A CoNvErT tHiS sTrInG tO aLl UpPeRcAsE";
	dk_call dk_echo "dk_toUpper = ${dk_toUpper}";
	
	### Result as parameter
	dk_call dk_echo
	dk_call dk_toUpper "B CoNvErT tHiS sTrInG tO aLl UpPeRcAsE" resultB;
	dk_call dk_echo "resultB = ${resultB}";
	dk_call dk_echo "dk_toUpper = ${dk_toUpper}";
	
	### Result as return value
	dk_call dk_echo
	$resultC=dk_call dk_toUpper "C CoNvErT tHiS sTrInG tO aLl UpPeRcAsE";
	dk_call dk_echo "resultC = ${resultC}";
	dk_call dk_echo "dk_toUpper = ${dk_toUpper}";
}
