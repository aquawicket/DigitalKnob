@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_halt()
::#
::#
:dk_halt
 setlocal
	call dk_debugFunc 0
	
	call:HALT %NO_STDERR%
	:HALT
		%dk_call% dk_echo "%red%###### HALT ######%clr%"
		()
goto:eof

::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_echo "calling dk_halt on next line"
	%dk_call% dk_halt
	%dk_call% dk_echo "this is the line after halt"
goto:eof
