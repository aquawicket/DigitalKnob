@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_echo(message)
::#
::#     Print a message to the console
::#
::#     @msg    - The message to print
::#
:dk_echo
    call dk_debugFunc 0 1
 setlocal
 
    if "%~1" equ "" (echo: & goto:eof)   
    set "_message_=%~1" 
        
    :: if msg starts and ends with quotes, remove the first and last characters
    ::%if_NDE% if "" == %_message_:~0,1%%_message_:~-1% set "msg=%_message_:~1,-1%"
    ::%if_DE% if "" == %_message_:~0,1%%_message_:~-1% set "msg=!_message_:~1,-1!"
        
    echo %_message_%
%endfunction%


set "dk_echo=echo"



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
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
