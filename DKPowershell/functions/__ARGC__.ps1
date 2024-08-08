if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
#if(!$DK_ARGC){ $DK_ARGC = 1 } else{ return }

##################################################################################
# __ARGC__(frame)
#
function GLOBAL:__ARGC__($_FRAME_=1) {
	return $(Get-PSCallStack)[$_FRAME_].InvocationInfo.BoundParameters.count;
}






function Global:DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### 
	Write-Host -Fore cyan "ARGC = $(__ARGC__ 0)";
}