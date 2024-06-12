if(!$DKINIT){ . $PWD\DK.ps1 }
#if(!$DK_ARGV){ $DK_ARGV = 1 } else{ return }
# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_automatic_variables?view=powershell-7.2


##################################################################################
# __ARGV__(frame)
#
function GLOBAL:__ARGV__($_FRAME_=2) {
#	$_FRAME_=$_FRAME_+1
#	$_ARGV_ = New-Object System.Collections.Generic.List[System.Object]
#	foreach($key in (Get-Command -Name $(__FUNCTION__ $_FRAME_)).Parameters.keys){
#		$_ARGV_.Add((get-variable $key).Value)
#	}
#	return $_ARGV_
	
	$_ARGV_ = New-Object System.Collections.Generic.List[System.Object]
	$boundParameters = $(Get-PSCallStack)[$_FRAME_].InvocationInfo.BoundParameters
	foreach ($keyValue in $boundParameters.GetEnumerator()) { 
		#echo "$($keyValue.Key) = $($keyValue.Value)" 
		$_ARGV_.Add($($keyValue.Value))
	}
	return $_ARGV_
}



function Global:DKTEST() { ###########################################################################################
	Write-Host -Fore cyan "ARGV = $(__ARGV__)";
}