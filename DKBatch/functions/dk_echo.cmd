@echo off
call DK.cmd

::################################################################################
::# dk_echo(message)
::#
::#	    Print a message to the console
::#
::#     @msg	- The message to print
::#
:dk_echo () {
    call dk_debugFunc
	if "%~1" equ "" (echo. & goto:eof)
	if %__ARGC__% neq 1 (call dk_error "%__FUNCTION__%(%__ARGS__%): incorrect number of arguments")
	
    setlocal enableDelayedExpansion
        set "_message_=%~1"	
        :: if msg starts and ends with quotes, remove the first and last
        if "" == %_message_:~0,1%%_message_:~-1% set "msg=!_message_:~1,-1!"
        echo %_message_%
    endlocal
goto:eof





:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
    call dk_debugFunc
	
	echo This is a normal echo commmand
	call dk_echo
	call dk_echo ""
	call dk_echo "This is a dk_echo line"
    call dk_echo "%red%This is %white%dk_echo %blue%with color %clr%"
goto:eof