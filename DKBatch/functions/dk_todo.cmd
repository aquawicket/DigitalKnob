@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::##################################################################################
::# dk_todo(message)
::#
::#    Print a todo message to the console
::#
::#    @message	- The message to print
::#
:dk_todo
	call dk_debugFunc 0 1
	call dk_log TODO "%~1"
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_todo "test dk_todo message"
goto:eof
