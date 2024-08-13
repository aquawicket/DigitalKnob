@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_function()
::#
::#
:dk_function
	call dk_debugFunc 0
	
	%dk_call% dk_todo
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_function
goto:eof
