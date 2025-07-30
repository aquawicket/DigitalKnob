if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_getParameterValue_ps1){ $dk_getParameterValue_ps1 = 1; } else{ return; } #include guard


################################################################################
# dk_getParameterValue()
#
#    Function description
#
#    @arg1	- arg1 description
#
function Global:dk_getParameterValue() {
	dk_debugFunc 0 99;

	$_NAME_ = $($args[0]);
	$n = 1;
	foreach($arg in $Args){
		if($n -eq 1){ $n++; continue; } 
		if(${arg} -eq $($args[0])){
			Write-Host "${arg} = $($args[$n])";
			Set-Variable -Name ${arg} -Value $($args[$n]) -Scope Global
			#Write-Host "dk_getParameterValue() $_NAME_  = $($args[$n])";
			return;
		}
		$n++;
	}
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;

	dk_call dk_getParameterValue;
}
