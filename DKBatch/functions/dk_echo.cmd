@echo off
call DK

::################################################################################
::# dk_echo(<message>)
::#
::#	    Print a message to the console
::#
::#     @msg	- The message to print
::#
:dk_echo () {
	::call dk_debugFunc
	
	setlocal enableDelayedExpansion	
		set "_message_=%1"
		
		:: if msg starts and ends with quotes, remove the first and last
		if "" == %_message_:~0,1%%_message_:~-1% set "msg=!_message_:~1,-1!"
		
		if "%*" equ "" ( echo. ) else ( echo %* )
	endlocal
goto:eof





:DKTEST ########################################################################

echo "This is a normal echo commmand"
call dk_echo "This is a dk_echo line"
call dk_echo "%cyan% This is dk_echo with color %clr%"