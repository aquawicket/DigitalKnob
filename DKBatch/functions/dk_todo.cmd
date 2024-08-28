@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::##################################################################################
::# dk_todo(message)
::#
::#    Print a todo message to the console
::#
::#    @message	- The message to print
::#
:dk_todo
 setlocal
	call dk_debugFunc 0 1
	
	%dk_call% dk_log TODO "%~1"
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_todo "test dk_todo message"
goto:eof
