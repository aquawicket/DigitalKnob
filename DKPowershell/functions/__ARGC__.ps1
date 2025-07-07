if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
#if(!$__ARGC___ps1){ $__ARGC___ps1 = 1; } else{ return; } #include guard


##################################################################################
# __ARGC__(frame)
#
function GLOBAL:__ARGC__($_FRAME_=1) {
	$BoundParameterCount = $(Get-PSCallStack)[$_FRAME_].InvocationInfo.BoundParameters.count;
	if ($(Get-PSCallStack)[$_FRAME_].InvocationInfo.BoundParameters[0].Value -eq ""){
		$BoundParameterCount = 0;
	}
	
	$UnboundArgumentCount = $(Get-PSCallStack)[$_FRAME_].InvocationInfo.UnboundArguments.count;
	if ($(Get-PSCallStack)[$_FRAME_].InvocationInfo.UnboundArguments[0].Value -eq ""){
		$UnboundArgumentCount = 0;
	}
	
	${__ARGC__} = ($BoundParameterCount + $UnboundArgumentCount);
	return ${__ARGC__};
}










###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	Write-Host -Fore cyan "ARGC = $(__ARGC__ 0)";
}