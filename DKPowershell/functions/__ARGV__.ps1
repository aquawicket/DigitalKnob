if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
#if(!$__ARGV___ps1){ $__ARGV___ps1 = 1; } else{ return; } #include guard
# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_automatic_variables?view=powershell-7.2

##################################################################################
# __ARGV__(frame)
#
function GLOBAL:__ARGV__($_FRAME_=1) {
	
	if(${_ARGV_}){
		Remove-Variable _ARGV_;
	}
	if($(Get-PSCallStack)[$_FRAME_].InvocationInfo.BoundParameters.count -gt 0){
		$boundParameters = $(Get-PSCallStack)[$_FRAME_].InvocationInfo.BoundParameters
		if(!(${_ARGV_})){
			${_ARGV_} = $boundParameters;
		} else {
			foreach($keyValue in $boundParameters.GetEnumerator()) {
				$_ARGV_.Add($($keyValue.Value))
			}
		}
	}
#	foreach($keyValue in $unboundArguments.GetEnumerator()) {
#		#echo "$($keyValue.Key) = $($keyValue.Value)"
#		#$_ARGV_.Add($($keyValue.Key))
#		$_ARGV_.Add($($keyValue.Value))
#	}

	if($(Get-PSCallStack)[$_FRAME_].InvocationInfo.UnboundArguments.count -gt 0){
		$unboundArguments = $(Get-PSCallStack)[$_FRAME_].InvocationInfo.UnboundArguments
		if(!(${_ARGV_})){
			${_ARGV_} = $unboundArguments;
		} else {
			foreach($keyValue in $unboundArguments.GetEnumerator()) {
				$_ARGV_.Add($($keyValue.Key), $($keyValue.Value))
			}
		}
	}
		
	if(${_ARGV_}){
		return $_ARGV_;
	} else {
		return;
	}
}

###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	Write-Host -Fore cyan "ARGV = $(__ARGV__ 0)";
}