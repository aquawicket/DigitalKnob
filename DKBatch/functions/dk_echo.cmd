@echo off
call dk_includeGuard
call DK

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: dk_echo(msg)
::
::
:dk_echo () {
	::call dk_debugFunc
	
	echo %*
goto:eof