@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# dk_pathExists(path rtn_var)
::#
:dk_pathExists
%setlocal%
    %dk_call% dk_debugFunc 1 2

    ::set "dk_pathExists=NOT ERRORLEVEL 1"
    
    ::set "_path=%~1"
    if exist "%~1" (
        if "%~2" neq "" (endlocal & set "%2=true")
        exit /b 0
    )
    
    if "%~2" neq "" (endlocal & set "%2=false")
    exit /b 1
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

    ::###### Using if return value
    %dk_call% dk_echo
    set "_path_=C:/Windows"
    %dk_call% dk_pathExists "%_path_%" result
    if /i "%result%" equ "true" (echo %_path_% exists) else (echo %_path_% does NOT exist)
    
    %dk_call% dk_echo
    set "_path_=C:/NonExistent"
    %dk_call% dk_pathExists "%_path_%" result
    if /i "%result%" equ "true" (echo %_path_% exists) else (echo %_path_% does NOT exist)
    ::FIXME: ERRORLEVEL is still 1 
    
    
    ::###### Using if ERRORLEVEL
    %dk_call% dk_echo
    set "_path_=C:/Windows"
    %dk_call% dk_pathExists "%_path_%"
    if not ERRORLEVEL 1 (echo %_path_% exists) else (echo %_path_% does NOT exist)
    
    %dk_call% dk_echo
    set "_path_=C:/NonExistent"
    %dk_call% dk_pathExists "%_path_%"
    if not ERRORLEVEL 1 (echo %_path_% exists) else (echo %_path_% does NOT exist)
    ::FIXME: ERRORLEVEL is still 1 
    
    
    ::###### Using && and || conditionals
    %dk_call% dk_echo
    set "_path_=C:/Windows" 
    %dk_call% dk_pathExists "%_path_%" && (echo %_path_% exists) || (echo %_path_% does NOT exist)
    
    %dk_call% dk_echo
    set "_path_=C:/NonExistent" 
    %dk_call% dk_pathExists "%_path_%" && (echo %_path_% exists) || (echo %_path_% does NOT exist)
    ::FIXME: ERRORLEVEL is still 1 
    
    
    ::###### Experimental
    ::  %dk_call% dk_echo
    ::  set "_path_=C:/Windows"
    ::  %dk_call% dk_pathExists "%_path_%"
    ::  if %dk_pathExists% (echo %_path_% exists) else (echo %_path_% does NOT exist)
    ::
    ::  %dk_call% dk_echo
    ::  set "_path_=C:/NonExistent"
    ::  %dk_call% dk_pathExists "%_path_%"
    ::  if %dk_pathExists% (echo %_path_% exists) else (echo %_path_% does NOT exist)
    ::  if not ERRORLEVEL 1 (echo ERRORLEVEL is 0) else (echo ERRORLEVEL is 1)
%endfunction%