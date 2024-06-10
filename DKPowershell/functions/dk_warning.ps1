if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_warning){ $dk_warning = 1 } else{ return }

dk_load dk_info
if(!$ENABLE_dk_warning){ $global:ENABLE_dk_warning = 1 }
if(!$TRACE_ON_WARNING) { $global:TRACE_ON_WARNING = 0  }
if(!$LINE_ON_WARNING)  { $global:LINE_ON_WARNING = 0   }
if(!$PAUSE_ON_WARNING) { $global:PAUSE_ON_WARNING = 0  }
if(!$HALT_ON_WARNING)  { $global:HALT_ON_WARNING = 0   }
#$WARNING_TAG="  WARNING: "
################################################################################
# dk_warning(<message>)
#
#    Print a warning message to the console
#
#    @message	- The message to print
#
function Global:dk_warning() {
	dk_debugFunc
	#$allArgs = $PsBoundParameters.Values + $args
	
	if($ENABLE_dk_warning -ne 1){ return }

	Write-Host -Fore yellow ${WARNING_TAG}${args}
	if($TRACE_ON_WARNING){ Write-Host -Fore yellow *** TRACE_ON_WARNING *** } #& dk_stacktrace
	if($LINE_ON_WARNING) { Write-Host -Fore yellow *** LINE_ON_WARNING ***  } #& dk_showFileLine "%_callerpath%" "%_message_%"
	if($PAUSE_ON_WARNING){ Write-Host -Fore yellow *** PAUSE_ON_WARNING *** } #& dk_pause
	if($HALT_ON_WARNING) { Write-Host -Fore yellow *** HALT_ON_WARNING ***  } #& dk_exit
}



function Global:DKTEST() { ###########################################################################################
	
	dk_warning "test dk_warning message"
	dk_info "...next line..."
}
