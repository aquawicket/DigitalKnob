@echo off
call DK

::################################################################################
::# dk_commandExists(<command> <result>)
::#
:dk_commandExists () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (call dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
    ::set "command=%~1"
 	cmd /c "(help %~1 > nul || exit 0) && where %~1 > nul 2> nul"
	
    if %ERRORLEVEL% equ 0 (
		if "%~2" neq "" endlocal & set "%2=true"
		(call )
		goto:eof
	)
	
	if "%~2" neq "" endlocal & set "%2=false"
    (call)
goto:eof





:DKTEST ########################################################################

    ::###### Using if return value
	echo.
	
	set "_command_=echo"
	call dk_commandExists "%_command_%" result
	if "%result%" equ "true" (echo %_command_% exists) else (echo %_command_% does NOT exists)
	
	set "_command_=NonExistentCommand"
	call dk_commandExists "%_command_%" result
	if "%result%" equ "true" (echo %_command_% exists) else (echo %_command_% does NOT exists)
	::FIXME: ERRORLEVEL is still 1 
	
	
	::###### Using if ERRORLEVEL
	echo.
	
	set "_command_=echo"
	call dk_commandExists "%_command_%"
	if not ERRORLEVEL 1 (echo %_command_% exists) else (echo %_command_% does NOT exists)
	
	set "_command_=NonExistentCommand"
	call dk_commandExists "%_command_%"
	if not ERRORLEVEL 1 (echo %_command_% exists) else (echo %_command_% does NOT exists)
	::FIXME: ERRORLEVEL is still 1 
	
	
	::###### Using && and || conditionals
	echo.
	
	set "_command_=echo"	
	call dk_commandExists "%_command_%" && (echo %_command_% exists) || (echo %_command_% does NOT exists)
	
	set "_command_=NonExistentCommand"	
	call dk_commandExists "%_command_%" && (echo %_command_% exists) || (echo %_command_% does NOT exists)
	::FIXME: ERRORLEVEL is still 1 
	
	
	
	
	
	
	