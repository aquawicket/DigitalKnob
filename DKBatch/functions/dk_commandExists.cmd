@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_commandExists(<command> rtn_var)
::#
:dk_commandExists
    call dk_debugFunc 1 2
 setlocal
 
    ::%dk_call% dk_set command "%~1"
    %ComSpec% /c "(help %~1 > nul || exit 0) && where %~1 > nul 2> nul"
    
    if %ERRORLEVEL% equ 0 (
        if "%~2" neq "" (endlocal & set "%2=true")
		echo TRUE
        exit /b 0
    )
    
    if "%~2" neq "" (endlocal & set "%2=false")
	echo FALSE
    exit /b 1
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
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
%endfunction%   
    