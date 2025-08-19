if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_basename_ps1){ $dk_basename_ps1 = 1; } else{ return; } #include guard

################################################################################
# dk_basename(_path, _rtn_var)
#
#	Strip directory AND suffix from filenames
#
#	Reference: https://stackoverflow.com/a/59739663/688352
#
function Global:dk_basename() {
	dk_debugFunc 1 2;

	###### input ######
	# $args[0] = _path
	# $args[1] = _rtn_var (optional)


	${_path} = $($args[0]);
	if( !${_path} ){ dk_call dk_error "_path is invalid"; }
	if(Test-Path variable:${_path}){ ${_path} = Get-Variable -Name (${_path}) -ValueOnly; } 
	if(${_path}){ ${dk_basename} = Split-Path ${_path} -leaf; }
	#Write-Host "dk_basename = ${dk_basename}";
	
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
	
	### Result as variable parameter
	dk_call dk_echo;
	dk_call dk_basename "B:/directoryB/filenameB.extB" resultB;
	dk_call dk_echo "resultB = ${resultB}";
	dk_call dk_echo "dk_basename = ${dk_basename}";
	
	### Result as return value
	dk_call dk_echo;
	$resultC = dk_call dk_basename "C:/directoryC/filenameC.extC";
	dk_call dk_echo "resultC = ${resultC}";
	dk_call dk_echo "dk_basename = ${dk_basename}";
	
	### Result as hashtable parameter
	dk_call dk_echo;
	dk_call dk_basename "D:/directoryD/filenameD.extD" resultD.value;
	dk_call dk_echo "resultD.value = ${resultD.value}";
	dk_call dk_echo "dk_basename = ${dk_basename}";
}
