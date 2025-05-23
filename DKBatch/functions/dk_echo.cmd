@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################################################################################
::# dk_echo(message)
::#
::#     Print a message to the console
::#
::#     @msg    - The message to print
::#
:dk_echo
setlocal
    %dk_call% dk_debugFunc 0 1

    if "%~1" equ "" (echo: & %endfunction%)   
    set "_message_=%~1" 
        
    :: if msg starts and ends with quotes, remove the first and last characters
    ::%if_NDE% if "" == %_message_:~0,1%%_message_:~-1% set "msg=%_message_:~1,-1%"
    ::%if_DE% if "" == %_message_:~0,1%%_message_:~-1% set "msg=!_message_:~1,-1!"
        
    echo %_message_%
%endfunction%


set "dk_echo=echo"



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
    %dk_call% dk_debugFunc 0

 
    echo This is a normal echo commmand
    %dk_call% dk_echo
    %dk_call% dk_echo ""
    %dk_call% dk_echo "This is a dk_echo line"
    %dk_call% dk_echo "%red%This is %white%dk_echo %blue%with color %clr%"
	
	echo This is a normal echo commmand
    %dk_call% dk_echo
    %dk_call% dk_echo ""
    %dk_call% dk_echo "This is a dk_echo line"
    %dk_call% dk_echo "%red%This is %white%dk_echo %blue%with color %clr%"
%endfunction%
