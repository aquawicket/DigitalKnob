if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_basename_ps1){ $dk_basename_ps1 = 1; } else{ return; } #include guard

################################################################################
# dk_basename(path, rtn_var)
#
#    reference: https://stackoverflow.com/a/59739663/688352
#
function Global:dk_basename() {
	dk_debugFunc 1 2;

	${_path_} = $args[0];
	if(Test-Path variable:${_path_}){ ${_path_} = Get-Variable -Name (${_path_}) -ValueOnly; } 
	
	${dk_basename} = Split-Path $_path_ -leaf;
	
	
	###### output ######
	${global:dk_basename} = ${dk_basename};
	if($args[1]) {
		dk_call dk_set $args[1] ${dk_basename};
	} else {
		return ${dk_basename};
	}
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;
	
	### Result as global variable
	dk_call dk_echo;
	dk_call dk_basename "A:/directoryA/filenameA.extA";
	dk_call dk_echo "dk_basename = ${dk_basename}";
	
	### Result as return value
	dk_call dk_echo;
	$resultB = dk_call dk_basename "B:/directoryB/filenameB.extB";
	dk_call dk_echo "resultB = ${resultB}";
	dk_call dk_echo "dk_basename = ${dk_basename}";
	
	### Result as variable parameter
	dk_call dk_echo;
	dk_call dk_basename "C:/directoryC/filenameC.extC" resultC;
	dk_call dk_echo "resultC = ${resultC}";
	dk_call dk_echo "dk_basename = ${dk_basename}";
	
	### Result as hashtable parameter
	dk_call dk_echo;
	dk_call dk_basename "D:/directoryD/filenameD.extD" resultD.data;
	dk_call dk_echo "resultD.data = $($resultD.data)";
	dk_call dk_echo "dk_basename = ${dk_basename}";
}
