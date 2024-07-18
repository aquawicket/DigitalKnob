if(!$DKINIT){ . $PWD/DK.ps1 }
#if(!$DK_LINE){ $DK_LINE = 1 } else{ return }

##################################################################################
# __LINE__(frame)
#
function GLOBAL:__LINE__($_FRAME_=1) {
	$_FRAME_=$_FRAME_+1
	return $(Get-PSCallStack)[$_FRAME_].ScriptLineNumber
}




function Global:DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### 
	Write-Host -Fore cyan "LINE = $(__LINE__ 0)";
}