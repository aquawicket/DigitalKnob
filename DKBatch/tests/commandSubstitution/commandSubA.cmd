@echo off
setlocal enableDelayedExpansion
if "!!" neq "" echo "delayed expansion is required" && pause && exit 

set "second=UNDEFINED"
set $time=>NULL<call:getTime


echo calling main
:main
	echo time = >%$time:#=!second!% seconds
	::echo time is %$test:#=!second!%
goto:main



  
:getTime
	echo :getTime
	:: https://stackoverflow.com/a/42199181/688352
	for /F "skip=1 usebackq delims=" %%A in (`wmic Path Win32_LocalTime Get Second`) do for /F "delims=" %%B in ("%%A") do (set "second=%%A")
goto:eof



