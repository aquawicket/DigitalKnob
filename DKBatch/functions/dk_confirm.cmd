@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"


::##################################################################################
::# dk_confirm()
::#
::#
:dk_confirm
	call dk_debugFunc 0
	
	setlocal
	set /P REPLY="%yellow% Are you sure ? [Y/N] %clr%"
	%dk_call% dk_echo
	%dk_call% dk_echo
	if /I "%REPLY%" equ "Y" (
		rem if defined "%~1" ( endlocal & %dk_call% dk_set %1 "true" )
        (call )
		goto:eof
	) 
	
	rem if not defined "%~1" ( endlocal & %dk_call% dk_set %1 "false" )
	(call)
	endlocal
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	::###### Using && and || conditionals
	%dk_call% dk_confirm && (echo "the confimation has passed") || (echo "the confimation has failed")
	
	::###### abort in not confirmed type code
	%dk_call% dk_confirm || goto:eof
	echo "passed the confirmation, executing code after confirm"
goto:eof
