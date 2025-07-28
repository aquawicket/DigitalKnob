if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_removeExtension_ps1){ $dk_removeExtension_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_removeExtension(filepath) -> rtn_var
#
#
function Global:dk_removeExtension() {
	dk_debugFunc 1 2;
	
	${global:dk_removeExtension} = $args[0].Substring(0, $args[0].lastIndexOf('.'));
	
	if($args[1]) {
		Set-Variable -Name $args[1] -Value ${dk_removeExtension} -Scope Global;
	} else {
		return ${dk_removeExtension};
	}
}











###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;
	
	### Result as global variable
	dk_call dk_echo
	dk_call dk_removeExtension "C:/test/test2/xfile.version.3.3.ext";
	dk_call dk_echo "dk_removeExtension = ${dk_removeExtension}";
	
	### Result as return value
	dk_call dk_echo
	$resultA = dk_call dk_removeExtension "C:/test/test1/xfile.version.1.1.ext";
	dk_call dk_echo "resultA = ${resultA}";
	dk_call dk_echo "dk_removeExtension = ${dk_removeExtension}";
	
	### Result as parameter
	dk_call dk_echo
	dk_call dk_removeExtension "C:/test/test2/xfile.version.2.2.ext" resultB;
	dk_call dk_echo "resultB = ${resultB}";
	dk_call dk_echo "dk_removeExtension = ${dk_removeExtension}";
}
