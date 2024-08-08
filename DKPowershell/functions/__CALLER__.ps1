if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
#if(!$DK_CALLER){ $DK_CALLER = 1 } else{ return }

##################################################################################
# __CALLER__(frame)
#
function GLOBAL:__CALLER__($_FRAME_=1) {
	$_FRAME_=$_FRAME_+1
	return ($(Get-PSCallStack)[$_FRAME_].FunctionName).Split(':')[1]
}



function Global:DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### 
	Write-Host -Fore cyan "CALLER = $(__CALLER__ 0)";
}