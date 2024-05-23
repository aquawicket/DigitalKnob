if (!$DKINIT){ . $PWD\DK.ps1 }

dk_load dk_echo
if (!$ENABLE_dk_info){ $global:ENABLE_dk_info = 1 }
if (!$TRACE_ON_INFO) { $global:TRACE_ON_INFO = 0  }
if (!$LINE_ON_INFO)  { $global:LINE_ON_INFO = 0   }
if (!$PAUSE_ON_INFO) { $global:PAUSE_ON_INFO = 0  }
if (!$HALT_ON_INFO)  { $global:HALT_ON_INFO = 0   }
$INFO_TAG="  INFO: "
################################################################################
# dk_info(<message>)
#
#    Print a info message to the console
#
#    @message	- The message to print
#
function Global:dk_info($_message_) {
	dk_debugFunc
	
	if ($ENABLE_dk_info -ne 1){ return }
	#::if "%*"==""  echo. & goto:eof                                                     &:: if arguments are empty, print a new line
	
	#set "_message_=%*"
	#if "" == %_message_:~0,1%%_message_:~-1% set "_message_=!_message_:~1,-1!"    &:: if _message_ starts and ends with quotes, remove them
		
	#echo %white%%INFO_TAG%%_message_%%clr%
	dk_echo "$_message_"
	$ENABLE_dk_debugFunc = 0
	if ($TRACE_ON_INFO){ dk_echo %blue%*** TRACE_ON_INFO ***%clr% } #& dk_stacktrace
	if ($LINE_ON_INFO) { dk_echo %blue%*** LINE_ON_INFO ***%crl%  } #& dk_showFileLine "%_callerpath%" "%_message_%"
	if ($PAUSE_ON_INFO){ dk_echo %blue%*** PAUSE_ON_INFO ***%clr% } #& dk_pause
	if ($HALT_ON_INFO) { dk_echo %blue%*** HALT_ON_INFO ***%clr%  } #& dk_exit

}



function Global:DKTEST() { ###########################################################################################
	
	dk_info "test message from dk_info"
}

