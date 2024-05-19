@echo off
call DK

::################################################################################
::# dk_commandExists(<command> <result>)
::#
:dk_commandExists () {
	call dk_debugFunc
	if %__ARGC__% lss 1 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
    ::set "command=%~1"
 	cmd /c "(help %~1 > nul || exit 0) && where %~1 > nul 2> nul"
	
    if %ERRORLEVEL% equ 0 (
		if not defined "%~2" goto:eof
		
		endlocal & set "%2=true"
		call dk_printVar "%2"
		(call )
		goto:eof
	)
	
	if not defined "%~2" goto:eof
	
	endlocal & set "%2=false"
	call dk_printVar "%2"
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
	
	
	
	
	
	
	