if (!$DKINIT){ . $PWD\DK.ps1 }

dk_load dk_info
if (!$ENABLE_dk_error){ $global:ENABLE_dk_error = 1 }
if (!$TRACE_ON_ERROR) { $global:TRACE_ON_ERROR = 0  }
if (!$LINE_ON_ERROR)  { $global:LINE_ON_ERROR = 0   }
if (!$PAUSE_ON_ERROR) { $global:PAUSE_ON_ERROR = 0  }
if (!$HALT_ON_ERROR)  { $global:HALT_ON_ERROR = 0   }
#$ERROR_TAG="  ERROR: "
################################################################################
# dk_error(<message>)
#
#    Print a error message to the console
#
#    @message	- The message to print
#
function Global:dk_error($allArgs) {
	dk_debugFunc
	$allArgs = $PsBoundParameters.Values + $args
	
	if ($ENABLE_dk_error -ne 1){ return }
	
	Write-Host -Fore red ${ERROR_TAG}${allArgs}
	if ($TRACE_ON_ERROR){ Write-Host -Fore red *** TRACE_ON_ERROR ***; dk_stacktrace }
	if ($LINE_ON_ERROR) { Write-Host -Fore red *** LINE_ON_ERROR ***;  dk_showFileLine $callerpath $message }
	if ($PAUSE_ON_ERROR){ Write-Host -Fore red *** PAUSE_ON_ERROR ***; dk_pause }
	if ($HALT_ON_ERROR) { Write-Host -Fore red *** HALT_ON_ERROR ***;  dk_exit }
}




function Global:DKTEST() { ###########################################################################################
	
	dk_error "test dk_error message"
	dk_info "...next line..."
}