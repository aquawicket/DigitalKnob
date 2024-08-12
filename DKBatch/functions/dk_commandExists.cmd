@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_commandExists(<command> rtn_var)
::#
:dk_commandExists
	call dk_debugFunc 1
	
	setlocal
    ::%dk_call% dk_set command "%~1"
 	cmd /c "(help %~1 > nul || exit 0) && where %~1 > nul 2> nul"
	
    if %ERRORLEVEL% equ 0 (
		if not defined "%~2" goto:eof
		
		endlocal & call set "%2=true"
		(call )
		goto:eof
	)
	
	if not defined "%~2" goto:eof
	
	endlocal & set "%2=false"
    (call)
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
    ::###### Using if return value
	%dk_call% dk_echo
	
	%dk_call% dk_set _command_ echo
	%dk_call% dk_commandExists "%_command_%" result
	if "%result%" equ "true" (echo %_command_% exists) else (echo %_command_% does NOT exists)
	
	%dk_call% dk_set _command_ NonExistentCommand
	%dk_call% dk_commandExists "%_command_%" result
	if "%result%" equ "true" (echo %_command_% exists) else (echo %_command_% does NOT exists)
	::FIXME: ERRORLEVEL is still 1 
	
	
	::###### Using if ERRORLEVEL
	%dk_call% dk_echo
	
	%dk_call% dk_set _command_ echo
	%dk_call% dk_commandExists "%_command_%"
	if not ERRORLEVEL 1 (echo %_command_% exists) else (echo %_command_% does NOT exists)
	
	%dk_call% dk_set _command_ NonExistentCommand
	%dk_call% dk_commandExists "%_command_%"
	if not ERRORLEVEL 1 (echo %_command_% exists) else (echo %_command_% does NOT exists)
	::FIXME: ERRORLEVEL is still 1 
	
	
	::###### Using && and || conditionals
	%dk_call% dk_echo
	
	%dk_call% dk_set _command_ echo	
	%dk_call% dk_commandExists "%_command_%" && (echo %_command_% exists) || (echo %_command_% does NOT exists)
	
	%dk_call% dk_set _command_ NonExistentCommand	
	%dk_call% dk_commandExists "%_command_%" && (echo %_command_% exists) || (echo %_command_% does NOT exists)
	::FIXME: ERRORLEVEL is still 1 
goto:eof	
	