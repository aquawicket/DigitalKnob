@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_echoNNL(message)
::#
::#     Print a message to the console without a new line
::#
::#     @msg    - The message to print
::#
:dk_echoNNL
    %dk_call% dk_debugFunc 0 1
 setlocal
 
	if "%~1" equ "" (goto:eof)   
    set "_message_=%~1" 
        
    :: if msg starts and ends with quotes, remove the first and last characters
    ::%if_NDE% if "" == %_message_:~0,1%%_message_:~-1% set "msg=%_message_:~1,-1%"
    ::%if_DE% if "" == %_message_:~0,1%%_message_:~-1% set "msg=!_message_:~1,-1!"
        
	set /P "=%_message_%" <nul
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    echo This is a normal echo commmand
    %dk_call% dk_echoNNL
    %dk_call% dk_echoNNL ""
    %dk_call% dk_echoNNL "This is a dk_echoNNL line"
    ::%dk_call% dk_echoNNL ""This is a dk_echo line with quotes""
    %dk_call% dk_echoNNL "%red%This is %white%dk_echoNNL %blue%with color %clr%"
%endfunction%
