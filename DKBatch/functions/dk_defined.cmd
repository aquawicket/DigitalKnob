@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::##################################################################################
::# dk_defined(<variable>, optional:<rtn_var>)
::#
:dk_defined
%setlocal%
	%dk_call% dk_debugFunc 1 2
 
    if defined %~1 (
		set "dk_defined=true"
        if "%~2" neq "" (endlocal & call set "%2=true")
        exit /b 0
    )
    
	set "dk_defined=false"
    if "%~2" neq "" (endlocal & call set "%2=false")
    exit /b 1
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

    ::###### Using if return value
    %dk_call% dk_echo
    %dk_call% dk_set _variable_ "is defined"
    %dk_call% dk_defined _variable_ result
    if "%result%" equ "true" (echo _variable_ is defined) else (echo _variable_ is NOT defined)
    
    %dk_call% dk_echo
    %dk_call% dk_unset _variable_
    %dk_call% dk_defined _variable_ result
    if "%result%" equ "true" (echo _variable_ is defined) else (echo _variable_ is NOT defined)
    ::FIXME: ERRORLEVEL is still 1 
    
    
    ::###### Using if ERRORLEVEL
    %dk_call% dk_echo
    %dk_call% dk_set _variable_ "is defined"
    %dk_call% dk_defined _variable_
    if not ERRORLEVEL 1 (echo _variable_ is defined) else (echo _variable_ is NOT defined)
    
    %dk_call% dk_echo
    %dk_call% dk_unset _variable_
    %dk_call% dk_defined _variable_
    if not ERRORLEVEL 1 (echo _variable_ is defined) else (echo _variable_ is NOT defined)
    ::FIXME: ERRORLEVEL is still 1 
    
    
    ::###### Using && and || conditionals
    %dk_call% dk_echo
    %dk_call% dk_set _variable_ "is defined"
    %dk_call% dk_defined _variable_ && (echo _variable_ is defined) || (echo _variable_ is NOT defined)

    %dk_call% dk_echo
    %dk_call% dk_unset _variable_
    %dk_call% dk_defined _variable_ && (echo _variable_ is defined) || (echo _variable_ is NOT defined)
    
	::FIXME: ERRORLEVEL is still 1
	(call )
%endfunction%
