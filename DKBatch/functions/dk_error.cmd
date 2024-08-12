@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

call dk_source dk_log
::################################################################################
::# dk_error(message)
::#
::#    Print a error message to the console
::#
::#    @message - The message to print
::#
:dk_error
	call dk_debugFunc 1
	call dk_log ERROR "%~1"
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_error "test dk_error message"
goto:eof
