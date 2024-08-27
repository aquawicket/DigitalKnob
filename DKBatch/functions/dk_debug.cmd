@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::##################################################################################
::# dk_debug(<message>)
::#
::#    Print a debug message to the console
::#
::#    @message	- The message to print
::#
:dk_debug
 setlocal
	call dk_debugFunc 1
	
	%dk_call% dk_log DEBUG "%~1"
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_debug "test dk_debug message"
goto:eof
