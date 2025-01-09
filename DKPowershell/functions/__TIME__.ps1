if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
#if(!$__TIME__){ $__TIME__ = 1 } else{ return } #include guard


##################################################################################
# __TIME__()
#
function GLOBAL:__TIME__() {
	#return $(Get-PSCallStack)[$_FRAME_].ScriptLineNumber
	return Get-Date -Format HH:mm:ss.ffff
}













###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	Write-Host -Fore cyan "TIME = $(__TIME__)";
}