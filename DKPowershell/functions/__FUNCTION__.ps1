if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
##TODO #include guard


##################################################################################
# __FUNCTION__(frame)
#
function GLOBAL:__FUNCTION__($_FRAME_=1) {
	return ($(Get-PSCallStack)[$_FRAME_].FunctionName).Split(':')[1]
}














###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	Write-Host -Fore cyan "FUNCTION = $(__FUNCTION__ 0)";
}