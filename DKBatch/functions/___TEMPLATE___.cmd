@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_function()
::#
::#
:dk_function
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_todo
 endlocal
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_function
 endlocal
goto:eof
