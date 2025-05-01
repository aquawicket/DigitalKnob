@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################################################################################
::# dk_echoNNL(message)
::#
::#     Print a message to the console without a new line
::#
::#     @msg    - The message to print
::#
:dk_echoNNL
%setlocal%
	%dk_call% dk_debugFunc 0 1

	if "%~1" equ "" (goto:eof)
	set "_message_=%~1" 

	::if msg starts and ends with quotes, remove the first and last characters
	::%if_NDE% if "" == %_message_:~0,1%%_message_:~-1% set "msg=%_message_:~1,-1%"
	::%if_DE% if "" == %_message_:~0,1%%_message_:~-1% set "msg=!_message_:~1,-1!"

	set /P "=%_message_%" <nul
(call )
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	echo This is a normal echo commmand
	%dk_call% dk_echoNNL
	%dk_call% dk_echoNNL ""
	%dk_call% dk_echoNNL "'dk_echoNNL test' "
	%dk_call% dk_echoNNL "'dk_echoNNL %red%test %white%with %blue%color%clr%' "
%endfunction%
