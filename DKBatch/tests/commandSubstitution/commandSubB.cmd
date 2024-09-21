@echo off
setlocal enableDelayedExpansion
if "!DE!" neq "" echo "delayed expansion is required" && pause && exit 

set "first=0"
set "middle=1"
set "last=2"

set $FIRST=%first%^&call:first&
set $MIDDLE=!middle!&call:middle
set $LAST=%last%^&call:last

set $time=call:getTime

echo FIRST LOOP
:main
	::echo 1 !$time:0=%second%!
	::set "second="
	
	::echo 2 %$time:0=!second!%
	::set "second="
	
	::echo 3 "!$time:0=%second%!"
	::set "second="
	
	::echo 4 "%$time:0=!second!%"
	::set "second="
	
	::echo 5 & %$time:!$time!=!$time!%
	::set "var=!$FIRST:%$MIDDLE%=%$LAST%!"
	set "var=%$FIRST:0=!$LAST!%"
	echo var = %var%
	set "second="
	
	echo:

goto:main



:first
	echo ###%0### first=%first% middle=%middle% last=%last%
%endfunction%
	
:middle
	echo ###%0### first=%first% middle=%middle% last=%last%
%endfunction%

:last
	echo ###%0### first=%first% middle=%middle% last=%last%
%endfunction%

  
:getTime
	echo :getTime
	:: https://stackoverflow.com/a/42199181/688352
	for /F "skip=1 usebackq delims=" %%A in (`wmic Path Win32_LocalTime Get Second`) do for /F "delims=" %%B in ("%%A") do (set "second=%%A")
%endfunction%



