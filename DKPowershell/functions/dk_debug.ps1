if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$dk_debug){ $dk_debug = 1 } else{ return }

dk_load dk_info
if (!$ENABLE_dk_debug){ $global:ENABLE_dk_debug = 1 }
if (!$TRACE_ON_DEBUG) { $global:TRACE_ON_DEBUG = 0  }
if (!$LINE_ON_DEBUG)  { $global:LINE_ON_DEBUG = 0   }
if (!$PAUSE_ON_DEBUG) { $global:PAUSE_ON_DEBUG = 0  }
if (!$HALT_ON_DEBUG)  { $global:HALT_ON_DEBUG = 0   }
#$DEBUG_TAG="  DEBUG: "
################################################################################
# dk_debug(<message>)
#
#    Print a debug message to the console
#
#    @message	- The message to print
#
function Global:dk_debug($allArgs) {
	dk_debugFunc
	$allArgs = $PsBoundParameters.Values + $args
	
	if ($ENABLE_dk_debug -ne 1){ return }

	Write-Host -Fore blue ${DEBUG_TAG}${allArgs}
	if ($TRACE_ON_DEBUG){ Write-Host -Fore blue *** TRACE_ON_DEBUG *** } #& dk_stacktrace
	if ($LINE_ON_DEBUG) { Write-Host -Fore blue *** LINE_ON_DEBUG ***  } #& dk_showFileLine "%_callerpath%" "%_message_%"
	if ($PAUSE_ON_DEBUG){ Write-Host -Fore blue *** PAUSE_ON_DEBUG *** } #& dk_pause
	if ($HALT_ON_DEBUG) { Write-Host -Fore blue *** HALT_ON_DEBUG ***  } #& dk_exit
}



function Global:DKTEST() { ###########################################################################################
	
	dk_debug "test dk_debug message"
	dk_info "...next line..."
}
