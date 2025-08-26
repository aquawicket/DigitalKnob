@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_commandExists(<command> rtn_var)
::#
:dk_commandExists
%setlocal%
	%dk_call% dk_debugFunc 1 2

    %ComSpec% /c "(help %~1 > nul || exit 0) && where %~1 > nul 2> nul"
   
    if %ERRORLEVEL% equ 0 (
		set "dk_commandExists=0"
    ) else (
		set "dk_commandExists=1"
	)
   
	::###### output ######
	endlocal & (
		set "dk_commandExists=%dk_commandExists%"
		if "%~2" neq "" (
			set "%~2=%dk_commandExists%"
		) else (
			echo %dk_commandExists%
		)
	)
	exit /b %dk_commandExists%
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

    ::###### Using if return value
    %dk_call% dk_echo
   
    %dk_call% dk_set _command_ echo
    %dk_call% dk_commandExists "%_command_%" result
    if /i "%result%" equ "0" (echo %_command_% exists) else (echo %_command_% does NOT EXIST)
   
    %dk_call% dk_set _command_ NonExistentCommand
    %dk_call% dk_commandExists "%_command_%" result
    if /i "%result%" equ "0" (echo %_command_% exists) else (echo %_command_% does NOT EXIST)
    ::FIXME: ERRORLEVEL is still 1
   
   
    ::###### Using if ERRORLEVEL
    %dk_call% dk_echo
   
    %dk_call% dk_set _command_ echo
    %dk_call% dk_commandExists "%_command_%"
    if NOT ERRORLEVEL 1 (echo %_command_% exists) else (echo %_command_% does NOT EXIST)
   
    %dk_call% dk_set _command_ NonExistentCommand
    %dk_call% dk_commandExists "%_command_%"
    if NOT ERRORLEVEL 1 (echo %_command_% exists) else (echo %_command_% does NOT EXIST)
    ::FIXME: ERRORLEVEL is still 1
   
   
    ::###### Using && and || conditionals
    %dk_call% dk_echo
   
    %dk_call% dk_set _command_ echo
    %dk_call% dk_commandExists "%_command_%" && (echo %_command_% exists) || (echo %_command_% does NOT EXIST)
   
    %dk_call% dk_set _command_ NonExistentCommand  
    %dk_call% dk_commandExists "%_command_%" && (echo %_command_% exists) || (echo %_command_% does NOT EXIST)
    ::FIXME: ERRORLEVEL is still 1
%endfunction%  
    