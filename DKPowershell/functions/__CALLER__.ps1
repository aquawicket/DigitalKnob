if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
#if(!$__CALLER__){ $__CALLER__ = 1 } else{ return } #include guard

##################################################################################
# __CALLER__(frame)
#
function GLOBAL:__CALLER__($_FRAME_=1) {
	$_FRAME_=$_FRAME_+1
	return ($(Get-PSCallStack)[$_FRAME_].FunctionName).Split(':')[1]
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	Write-Host -Fore cyan "CALLER = $(__CALLER__ 0)";
}