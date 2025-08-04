if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_basename_ps1){ $dk_basename_ps1 = 1; } else{ return; } #include guard

################################################################################
# dk_basename(path) -> rtn_var
#
#    reference: https://stackoverflow.com/a/59739663/688352
#
function Global:dk_basename() {
	dk_debugFunc 1 2;

	$_path_ = $args[0];
	if(Test-Path variable:$_path_){ $_path_ = Get-Variable -Name ($_path_) -ValueOnly } 
	
	${global:dk_basename} = Split-Path $_path_ -leaf;
	
	if($args[1]) {
		Write-Host "args[1] = $($args[1])";
		Write-Host "dk_basename = ${dk_basename}";
		Set-Variable -Name "$($args[1])" -Value "${dk_basename}" -Scope Global;
		Set-Variable -Name "resultD.test" -Value "${dk_basename}";
	} else {
		return ${dk_basename};
	}
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;
	
	### Result as global variable
	dk_call dk_echo
	dk_call dk_basename "A:/directoryA/filenameA.extA";
	dk_call dk_echo "dk_basename = ${dk_basename}";
	
	### Result as parameter name
	dk_call dk_echo
	dk_call dk_basename "B:/directoryB/filenameB.extB" resultB;
	dk_call dk_echo "resultB = ${resultB}";
	dk_call dk_echo "dk_basename = ${dk_basename}";
	
	### Result as return value
	dk_call dk_echo
	$resultC = dk_call dk_basename "C:/directoryC/filenameC.extC";
	dk_call dk_echo "resultC = ${resultC}";
	dk_call dk_echo "dk_basename = ${dk_basename}";
	
	### Result as parameter variable
	$resultD = @{ "Key" = "Value" };
	#$resultD['test'] = "success";
	#$resultD.test = "success";
	dk_call dk_echo
	dk_call dk_basename "D:/directoryD/filenameD.extD" resultD.test;
	dk_call dk_echo "resultD['test'] = $($resultD['test'])";
	dk_call dk_echo "resultD.test = $($resultD.test)";
	dk_call dk_echo "dk_basename = ${dk_basename}";
	
	
	#$MyHashtable = @{};
	#$MyHashtable.data = "old value"
	#$MyHashtable.data;
	$var = "MyHashtable.data"
	
	$myVar = "old var value";
	$myVar;
	$var = "myVar";
	
	$new_value = "new value";
	
	$var_arry = $var.Split(".");

	if($var_arry[1]){
		$(Get-Variable -Name $var_arry[0] -ValueOnly)[$var_arry[1]] = $new_value;
	} else {
		Set-Variable -Name $var_arry[0] -Value $new_value;
	}
	
	#$MyHashtable.data;
	$myVar;
}
