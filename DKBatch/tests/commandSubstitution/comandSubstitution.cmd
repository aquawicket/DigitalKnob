@echo off

(set \n=^^^
%= This creates an escaped Line Feed - DO NOT ALTER =%
)

setlocal enableDelayedExpansion

set $time=^&call:getTime^&echo

:main
	::for /f "usebackq tokens=*" %%a in (`time /t`) do echo %%a
	
	::call :getTime
	::echo time is &call:getTime
	echo ^> !$time:%$time%=%second%! ^<
	::echo the time is !$time:%$time%:%second%! seconds
	goto main
%endfunction%


 
:getTime
	::echo :getTime
	:: https://stackoverflow.com/a/42199181/688352
	for /F "skip=1 usebackq delims=" %%A in (`wmic Path Win32_LocalTime Get Second`) do for /F "delims=" %%B in ("%%A") do (set "second=%%A")
%endfunction%



