if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_basename_ps1){ $dk_basename_ps1 = 1; } else{ return; } #include guard

################################################################################
# dk_basename(path) -> rtn_var
#
#    reference: https://stackoverflow.com/a/59739663/688352
#
function Global:dk_basename() {
	dk_debugFunc 1 2;

	${global:dk_basename} = Split-Path $args[0] -leaf;
	
	if($args[1]) {
		Set-Variable -Name $args[1] -Value ${dk_basename} -Scope Global;
	} else {
		return ${dk_basename};
	}
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;
	
	### Result as global variable
	dk_call dk_echo
	dk_call dk_basename "C:/test/test2/file.version.3.3.ext";
	dk_call dk_echo "dk_basename = ${dk_basename}";
	
	### Result as return value
	dk_call dk_echo
	$resultA = dk_call dk_basename "C:/test/test1/file.version.1.1.ext";
	dk_call dk_echo "resultA = ${resultA}";
	dk_call dk_echo "dk_basename = ${dk_basename}";
	
	### Result as parameter
	dk_call dk_echo
	dk_call dk_basename "C:/test/test2/file.version.2.2.ext" resultB;
	dk_call dk_echo "resultB = ${resultB}";
	dk_call dk_echo "dk_basename = ${dk_basename}";
}
