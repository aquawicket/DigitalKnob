if (!$DKINIT){ . $PWD\DK.ps1 }

dk_load dk_echo
if (!$ENABLE_dk_info){ $global:ENABLE_dk_info = 1 }
if (!$TRACE_ON_INFO) { $global:TRACE_ON_INFO = 0  }
if (!$LINE_ON_INFO)  { $global:LINE_ON_INFO = 0   }
if (!$PAUSE_ON_INFO) { $global:PAUSE_ON_INFO = 0  }
if (!$HALT_ON_INFO)  { $global:HALT_ON_INFO = 0   }
#$global:INFO_TAG = "  INFO: "
################################################################################
# dk_info(<message>)
#
#    Print a info message to the console
#
#    @message	- The message to print
#
function Global:dk_info($allArgs) {
	dk_debugFunc
	$allArgs = $PsBoundParameters.Values + $args
	
	if ($ENABLE_dk_info -ne 1){ return }
		
	Write-Host -Fore white ${INFO_TAG}${allArgs}
	if ($TRACE_ON_INFO){ Write-Host -Fore white *** TRACE_ON_INFO ***; dk_stacktrace }
	if ($LINE_ON_INFO) { Write-Host -Fore white *** LINE_ON_INFO ***;  dk_showFileLine $callerpath $message }
	if ($PAUSE_ON_INFO){ Write-Host -Fore white *** PAUSE_ON_INFO ***; dk_pause }
	if ($HALT_ON_INFO) { Write-Host -Fore white *** HALT_ON_INFO ***;  dk_exit }
}



function Global:DKTEST() { ###########################################################################################
	
	dk_info "test message from dk_info"
}

