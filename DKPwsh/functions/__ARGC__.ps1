if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
#if(!$DK_ARGC){ $DK_ARGC = 1 } else{ return }


##################################################################################
# __ARGC__(frame)
#
function GLOBAL:__ARGC__($_FRAME_=1) {
	#$ubpc = $(Get-PSCallStack)[$_FRAME_].InvocationInfo.UnboundArguments.count
	#$bpc = $(Get-PSCallStack)[$_FRAME_].InvocationInfo.BoundParameters.count
	#Write-Host "Bound = $bpc, Unbound = $ubpc"
	return $(Get-PSCallStack)[$_FRAME_].InvocationInfo.BoundParameters.count; 
	
}










###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	Write-Host -Fore cyan "ARGC = $(__ARGC__ 0)";
}