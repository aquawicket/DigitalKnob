@echo off
call DK


::##################################################################################
::# dk_confirm()
::#
::#
:dk_confirm () {
	call dk_debugFunc
	if %__ARGC__% NEQ 0 (dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	set /P REPLY="%yellow% Are you sure ? [Y/N] %clr%"
	call dk_echo
	call dk_echo
	if /I "%REPLY%" equ "Y" (
		if "%~2" neq "" endlocal & set "%2=true"
        (call )
		goto:eof
	) 
	
	 if "%~2" neq "" endlocal & set "%2=false"
	(call)
goto:eof





:DKTEST ########################################################################
	
	::###### Using && and || conditionals
	call dk_confirm && (echo "the confimation has passed") || (echo "the confimation has failed")
	
	::###### abort in not confirmed type code
	call dk_confirm || goto:eof
	echo "passed the confirmation, executing code after confirm"