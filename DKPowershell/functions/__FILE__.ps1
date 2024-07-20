if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
#if(!$DK_FILE){ $DK_FILE = 1 } else{ return }

##################################################################################
# __FILE__(frame)
#
function GLOBAL:__FILE__($_FRAME_=1) {
	$_FRAME_=$_FRAME_+1
	return ($(Get-PSCallStack)[$_FRAME_].Location).Split(':')[0]
}



function Global:DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### 
	Write-Host -Fore cyan "FILE = $(__FILE__ 0)";
}