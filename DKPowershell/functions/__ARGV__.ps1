if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
#if(!$__ARGV__){ $__ARGV__ = 1 } else{ return } #include guard
# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_automatic_variables?view=powershell-7.2

##################################################################################
# __ARGV__(frame)
#
function GLOBAL:__ARGV__($_FRAME_=1) {
	$_ARGV_ = New-Object System.Collections.Generic.List[System.Object]
	$boundParameters = $(Get-PSCallStack)[$_FRAME_].InvocationInfo.BoundParameters
	foreach($keyValue in $boundParameters.GetEnumerator()) {
		#echo "$($keyValue.Key) = $($keyValue.Value)"
		#$_ARGV_.Add($($keyValue.Key))
		$_ARGV_.Add($($keyValue.Value))
	}
	$unboundArguments = $(Get-PSCallStack)[$_FRAME_].InvocationInfo.UnboundArguments
#	foreach($keyValue in $unboundArguments.GetEnumerator()) {
#		#echo "$($keyValue.Key) = $($keyValue.Value)"
#		#$_ARGV_.Add($($keyValue.Key))
#		$_ARGV_.Add($($keyValue.Value))
#	}
	return $_ARGV_+$unboundArguments
}

###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	Write-Host -Fore cyan "ARGV = $(__ARGV__ 0)";
}