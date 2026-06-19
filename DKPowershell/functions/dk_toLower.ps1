if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_toLower_ps1){ $dk_toLower_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_toLower(str, rtnvar)
#
#
function Global:dk_toLower() {
	dk_debugFunc 1 2;

	$str = $args[0];
	${global:dk_toLower} = ${str}.ToLower();

	if($args[1]) {
		dk_call dk_set $args[1] ${dk_toLower};
	} else {
		return ${dk_toLower};
	}
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;
	
	### Result as global variable
	dk_call dk_echo
	dk_call dk_toLower "A CoNvErT tHiS sTrInG tO aLl LowercAsE";
	dk_call dk_echo "dk_toLower = ${dk_toLower}";
	
	### Result as parameter
	dk_call dk_echo
	dk_call dk_toLower "B CoNvErT tHiS sTrInG tO aLl LowercAsE" resultB;
	dk_call dk_echo "resultB = ${resultB}";
	dk_call dk_echo "dk_toLower = ${dk_toLower}";
	
	### Result as return value
	dk_call dk_echo
	$resultC=dk_call dk_toLower "C CoNvErT tHiS sTrInG tO aLl LowercAsE";
	dk_call dk_echo "resultC = ${resultC}";
	dk_call dk_echo "dk_toLower = ${dk_toLower}";
}
