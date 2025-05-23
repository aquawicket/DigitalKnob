@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################################################################################
::# dk_echoReplace(message)
::#
::#     Print a message to the console
::#
::#     @msg    - The message to print
::#
:dk_echoReplace
setlocal
    %dk_call% dk_debugFunc 0 1

 
    if "%~1" equ "" (goto:eof)   
    set "_message_=%~1" 
        
    :: if msg starts and ends with quotes, remove the first and last characters
    ::%if_NDE% if "" == %_message_:~0,1%%_message_:~-1% set "msg=%_message_:~1,-1%"
    ::%if_DE% if "" == %_message_:~0,1%%_message_:~-1% set "msg=!_message_:~1,-1!"
        
	::if not defined CR  (for /f %%a in ('copy /Z "%~dpf0" nul') do set "CR=%%a")
	for /f %%a in ('copy /Z "%~dpf0" nul') do (set "CR=%%a")
	set /P "=%_message_%                                          !CR!" <nul
	(call )
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    echo This is a normal echo commmand
    %dk_call% dk_echoReplace
    %dk_call% dk_echoReplace ""
    %dk_call% dk_echoReplace "This is a dk_echoReplace line"
	%dk_call% dk_sleep 1
	%dk_call% dk_echoReplace "Another dk_echoReplace line"
	%dk_call% dk_sleep 1
	echo This is a normal echo commmand
	%dk_call% dk_sleep 1
	%dk_call% dk_echoReplace "and another dk_echoReplace line"
	%dk_call% dk_sleep 1
    %dk_call% dk_echoReplace """This is a dk_echoReplace line with quotes"""
	%dk_call% dk_sleep 1
    %dk_call% dk_echoReplace "This is %red%dk_echoReplace %blue%with color%clr%"
	%dk_call% dk_sleep 1
	%dk_call% dk_echoReplace "The last dk_echoReplace line loses it's first character"
	%dk_call% dk_sleep 3
%endfunction%
