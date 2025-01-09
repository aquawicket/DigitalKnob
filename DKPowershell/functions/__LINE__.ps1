if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
##TODO #include guard


##################################################################################
# __LINE__(frame)
#
function GLOBAL:__LINE__($_FRAME_=1) {
	$_FRAME_=$_FRAME_+2
	return $(Get-PSCallStack)[$_FRAME_].ScriptLineNumber
}













###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	Write-Host -Fore cyan "LINE = $(__LINE__ 0)";
}