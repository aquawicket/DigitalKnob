@echo off

(set \n=^^^
%= This creates an escaped Line Feed - DO NOT ALTER =%
)

setlocal enableDelayedExpansion

if "!!" equ "" echo Delayed Expansion ON
if "!!" neq "" echo Delayed Expansion OFF

set $time=^&call:getTime^&echo
set $timeB=^&call:getTime^&echo %$timeB%

set $first=^&call:first
set $middle=^&call:middle
set $last=^&call:last

:main
	::for /f "usebackq tokens=*" %%a in (`time /t`) do echo %%a

	::echo ^^!$first^^! = !$first!
	::echo %%$fisrt%% = %$first%
	
	::echo !first!
	echo --------------------------
	echo !%$first%:%$middle%=%$last%!
	
	::echo %$firstB:!$middleB!=!$lastB!%
	::echo %%$first%% = %$first%
	::echo %$first%
	
	::echo %$first:!middle!%
	::echo !$first:%$middle%=%$end%!
	::echo !$first:%$middle%=%$end%!
	
	
	::set var=%$time%
	::echo var = %var%
	
	::call :getTime
	::echo time is &call:getTime
	::echo START !%$time%=%second%! END
	::echo ^> !$time:%$time%=%second%! ^<
	::echo ^> !$time:%$time%=%second%! ^<
	
	::echo the time is !$time:%$time%:%second%! seconds
	goto:main
goto:eof


:first
	echo ###%0###
goto:eof

:middle
	echo ###%0###
goto:eof

:last
	echo ###%0###
goto:eof
  
:getTime
	echo :getTime
	:: https://stackoverflow.com/a/42199181/688352
	::for /F "skip=1 usebackq delims=" %%A in (`wmic Path Win32_LocalTime Get Second`) do for /F "delims=" %%B in ("%%A") do (set "second=%%A" ^ set "timeB=%%A")
	for /F "skip=1 usebackq delims=" %%A in (`wmic Path Win32_LocalTime Get Second`) do for /F "delims=" %%B in ("%%A") do (echo %%A)
goto:eof



