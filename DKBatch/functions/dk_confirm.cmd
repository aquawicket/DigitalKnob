@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::##################################################################################
::# dk_confirm()
::#
:dk_confirm
setlocal
	%dk_call% dk_debugFunc 0

    set /P REPLY="%yellow% Are you sure ? [Y/N] %clr%"
    echo:
	echo:
    if /I "%REPLY%" equ "Y" (
        rem if "%~1" neq "" ( endlocal & %dk_call% dk_set %1 "true" )
        exit /b 0
    ) 
    
    rem if "%~1" neq "" ( endlocal & %dk_call% dk_set %1 "false" )
    exit /b 1
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    ::###### Using && and || conditionals
    %dk_call% dk_confirm && (echo "the confimation has passed") || (echo "the confimation has failed")
    
    ::###### abort in not confirmed type code
    ::%dk_call% dk_confirm || (%return%)
	%dk_call% dk_confirm || (dk_return)
    echo "passed the confirmation, executing code after confirm"
%endfunction%
