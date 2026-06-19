if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_toUpper_ps1){ $dk_toUpper_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_toUpper(str, rtnvar)
#
#
function Global:dk_toUpper() {
	dk_debugFunc 1 2;

	${_str_} = $args[0];
	#if(Test-Path variable:$_str_){ $_str_ = Get-Variable -Name ($_str_) -ValueOnly; } 
	
	${global:dk_toUpper} = ${_str_}.ToUpper();

	if($args[1]) {
		dk_call dk_set $args[1] ${dk_toUpper};
	} else {
		return ${dk_toUpper};
	}
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;
	
	### Result as global variable
	dk_call dk_echo;
	dk_call dk_toUpper "A:/directoryA/filenameA.extA";
	dk_call dk_echo "dk_toUpper = ${dk_toUpper}";
	
	### Result as return value
	dk_call dk_echo;
	$resultB=dk_call dk_toUpper "B:/directoryB/filenameB.extB";
	dk_call dk_echo "resultB = ${resultB}";
	dk_call dk_echo "dk_toUpper = ${dk_toUpper}";
	
	### Result as variable parameter
	dk_call dk_echo;
	dk_call dk_toUpper "C:/directoryC/filenameC.extC" resultC;
	dk_call dk_echo "resultC = ${resultC}";
	dk_call dk_echo "dk_toUpper = ${dk_toUpper}";
	
	### Result as hashtable parameter
	dk_call dk_echo;
	dk_call dk_toUpper "D:/directoryD/filenameD.extD" resultD.data;
	dk_call dk_echo "resultD.data = $($resultD.data)";
	dk_call dk_echo "dk_toUpper = ${dk_toUpper}";
}
