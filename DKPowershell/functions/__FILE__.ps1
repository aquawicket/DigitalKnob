<<<<<<< HEAD
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
#if(!$DK_FILE){ $DK_FILE = 1 } else{ return }
=======
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
#if(!$__FILE__){ $__FILE__ = 1 } else{ return } #include guard
>>>>>>> Development


##################################################################################
# __FILE__(frame)
#
function GLOBAL:__FILE__($_FRAME_=1) {
	$_FRAME_=$_FRAME_+2
	
	if($(Get-PSCallStack)[$_FRAME_]){
		return $(Get-PSCallStack)[$_FRAME_].Location.Split(':')[0]
	}
}













###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	Write-Host -Fore cyan "FILE = $(__FILE__ 0)";
}