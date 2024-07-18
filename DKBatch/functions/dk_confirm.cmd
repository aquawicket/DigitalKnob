@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd


::##################################################################################
::# dk_confirm()
::#
::#
:dk_confirm
	call dk_debugFunc
	if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	set /P REPLY="%yellow% Are you sure ? [Y/N] %clr%"
	call dk_echo
	call dk_echo
	if /I "%REPLY%" equ "Y" (
		rem if defined "%~1" ( endlocal & call dk_set %1 "true" )
        (call )
		goto:eof
	) 
	
	rem if not defined "%~1" ( endlocal & call dk_set %1 "false" )
	(call)
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	::###### Using && and || conditionals
	call dk_confirm && (echo "the confimation has passed") || (echo "the confimation has failed")
	
	::###### abort in not confirmed type code
	call dk_confirm || goto:eof
	echo "passed the confirmation, executing code after confirm"
goto:eof
