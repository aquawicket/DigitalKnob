@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::#####################################################################
::# dk_Target_Type(rtn_var:Target_Type)
::#
::#
:dk_Target_Type
::%setlocal%
	%dk_call% dk_debugFunc 0 1
 
    %dk_call% dk_echo
    %dk_call% dk_echo "%Target_App% %Target_Tuple% %Target_Type%"
    %dk_call% dk_echo
    echo 1) Debug
    echo 2) Release
    echo 3) All
    echo 4) Go Back
    echo 5) Exit
    
    %dk_call% dk_echo 
    %dk_call% dk_echo "Please select a build type."
    
    %dk_call% dk_keyboardInput choice
    ::%dk_call% dk_keyboardInputTimeout 1 60 choice

    if "%choice%" equ "1" (endlocal & set "%1=Debug"			& %return%)
    if "%choice%" equ "2" (endlocal & set "%1=Release"			& %return%)
    if "%choice%" equ "3" (endlocal & set "%1=All"				& %return%)
    if "%choice%" equ "4" (%dk_call% dk_unset Target_Tuple		& %return%)
    if "%choice%" equ "5" (%dk_call% dk_exit					& %return%)

    %dk_call% dk_echo %choice%: invalid selection, please try again
    %dk_call% dk_unset Target_Type
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

    ::###### GET ######
    %dk_call% dk_Target_Type
	%dk_call% dk_printVar Target_Type
	%dk_call% dk_printVar %Target_Type%
	
	::###### SET ######
	%dk_call% dk_Target_Type "Windows"
	%dk_call% dk_printVar Target_Type
	%dk_call% dk_printVar %Target_Type%
%endfunction%
