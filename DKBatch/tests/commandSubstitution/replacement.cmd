@echo off

(set \n=^^^
%= This creates an escaped Line Feed - DO NOT ALTER =%
)

setlocal enableDelayedExpansion

if "!DE!" equ "" echo Delayed Expansion ON
if "!DE!" neq "" echo Delayed Expansion OFF

set $time=^&call:getTime^&echo
set $timeB=^&call:getTime^&echo %$timeB%

set "$dummy= "
set "first=0"
set "middle=0"
set "last=2"
set $FIRST=%first%&call:first&
set $MIDDLE=%middle%&call:middle&
set $LAST=%last%&call:last&

set $MACRO=%$FIRST:0=!$LAST!%
::set "first=Value"

set $_SECOND=&call:getTime
set $SECOND_=%second%
set $SECOND=!%$_SECOND:%$SECOND%=%second%!
:main
	::for /f "usebackq tokens=*" %%a in (`time /t`) do echo %%a

	::echo ^^!$first^^! = !$first!
	::echo %%$fisrt%% = %$first%
	
	::echo !first!
	echo --------------------------
	::echo !%$first%:%$middle%=%$last%!
	::set "var=!%$first%:=END!"
	set sec=!$SECOND!
	echo sec = %sec%
	
::	set value=!$MACRO!
::	echo value = %value%
	
	::set var=%$FIRST:!$MIDDLE!=!$LAST!%
	::echo var = %var%
	::echo %$first%%$middle%%$last%
	
	
	::echo START !%$time%=%second%! END
	::echo !%$first%:%$middle%=%$last%!
	::echo !%$dummy%:%$middle%=%$last%!
	
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
%endfunction%


:first
	echo ###%0### first=%first% middle=%middle% last=%last%
	set "last=9"
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



