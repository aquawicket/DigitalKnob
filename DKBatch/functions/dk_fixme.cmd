@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

call dk_source dk_log
::################################################################################
::# dk_fixme(message)
::#
::#    Print a fixme message to the console
::#
::#    @message - The message to print
::#
:dk_fixme
	call dk_debugFunc 1
	call dk_log FIXME "%~1"
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_fixme "test dk_fixme message"
goto:eof
