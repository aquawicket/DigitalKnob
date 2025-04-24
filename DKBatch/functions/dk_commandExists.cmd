<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

>>>>>>> Development

::################################################################################
::# dk_commandExists(<command> rtn_var)
::#
:dk_commandExists
<<<<<<< HEAD
    call dk_debugFunc 1 2
 setlocal
 
    ::%dk_call% dk_set command "%~1"
=======
setlocal
	%dk_call% dk_debugFunc 1 2
 
>>>>>>> Development
    %ComSpec% /c "(help %~1 > nul || exit 0) && where %~1 > nul 2> nul"
    
    if %ERRORLEVEL% equ 0 (
        if "%~2" neq "" (endlocal & set "%2=true")
<<<<<<< HEAD
		echo TRUE
=======
		rem echo TRUE
>>>>>>> Development
        exit /b 0
    )
    
    if "%~2" neq "" (endlocal & set "%2=false")
<<<<<<< HEAD
	echo FALSE
=======
	rem echo FALSE
>>>>>>> Development
    exit /b 1
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
=======
setlocal
	%dk_call% dk_debugFunc 0

>>>>>>> Development
    ::###### Using if return value
    %dk_call% dk_echo
    
    %dk_call% dk_set _command_ echo
    %dk_call% dk_commandExists "%_command_%" result
<<<<<<< HEAD
    if "%result%" equ "true" (echo %_command_% exists) else (echo %_command_% does NOT exists)
    
    %dk_call% dk_set _command_ NonExistentCommand
    %dk_call% dk_commandExists "%_command_%" result
    if "%result%" equ "true" (echo %_command_% exists) else (echo %_command_% does NOT exists)
=======
    if "%result%" equ "true" (echo %_command_% exists) else (echo %_command_% does NOT exist)
    
    %dk_call% dk_set _command_ NonExistentCommand
    %dk_call% dk_commandExists "%_command_%" result
    if "%result%" equ "true" (echo %_command_% exists) else (echo %_command_% does NOT exist)
>>>>>>> Development
    ::FIXME: ERRORLEVEL is still 1 
    
    
    ::###### Using if ERRORLEVEL
    %dk_call% dk_echo
    
    %dk_call% dk_set _command_ echo
    %dk_call% dk_commandExists "%_command_%"
<<<<<<< HEAD
    if not ERRORLEVEL 1 (echo %_command_% exists) else (echo %_command_% does NOT exists)
    
    %dk_call% dk_set _command_ NonExistentCommand
    %dk_call% dk_commandExists "%_command_%"
    if not ERRORLEVEL 1 (echo %_command_% exists) else (echo %_command_% does NOT exists)
=======
    if not ERRORLEVEL 1 (echo %_command_% exists) else (echo %_command_% does NOT exist)
    
    %dk_call% dk_set _command_ NonExistentCommand
    %dk_call% dk_commandExists "%_command_%"
    if not ERRORLEVEL 1 (echo %_command_% exists) else (echo %_command_% does NOT exist)
>>>>>>> Development
    ::FIXME: ERRORLEVEL is still 1 
    
    
    ::###### Using && and || conditionals
    %dk_call% dk_echo
    
    %dk_call% dk_set _command_ echo 
<<<<<<< HEAD
    %dk_call% dk_commandExists "%_command_%" && (echo %_command_% exists) || (echo %_command_% does NOT exists)
    
    %dk_call% dk_set _command_ NonExistentCommand   
    %dk_call% dk_commandExists "%_command_%" && (echo %_command_% exists) || (echo %_command_% does NOT exists)
=======
    %dk_call% dk_commandExists "%_command_%" && (echo %_command_% exists) || (echo %_command_% does NOT exist)
    
    %dk_call% dk_set _command_ NonExistentCommand   
    %dk_call% dk_commandExists "%_command_%" && (echo %_command_% exists) || (echo %_command_% does NOT exist)
>>>>>>> Development
    ::FIXME: ERRORLEVEL is still 1 
%endfunction%   
    