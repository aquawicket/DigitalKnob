@echo off
call DK

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: dk_echo(msg)
::
::
:dk_echo () {
	::call dk_debugFunc
	
	if "%*" EQU "" ( echo. ) else ( echo %* )
goto:eof





:DKTEST ########################################################################

echo "This is a normal echo commmand"
call dk_echo "This is a dk_echo line"
call dk_echo "%cyan% This is dk_echo with color %clr%"