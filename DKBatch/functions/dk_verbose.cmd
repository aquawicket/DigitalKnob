@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"


::################################################################################
::# dk_verbose(message)
::#
::#	   Print a verbose message to the console
::#
::#    @message	- The message to print
::#
:dk_verbose
	call dk_debugFunc 1
	call dk_log VERBOSE "%~1"
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_verbose "test dk_verbose message"
goto:eof
