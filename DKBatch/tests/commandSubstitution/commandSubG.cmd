@echo off
setlocal enableDelayedExpansion
if "!DE!" neq "" echo "delayed expansion is required" && pause && exit 

(set \n=^^^
%= This creates an escaped Line Feed - DO NOT ALTER =%
)


set $time=0^&call:getTime
:main
	::echo %$time%
	::%$time% >> file.txt
	set sec=%$time:0=!second!%
	call:printTime "%sec%"
	echo %sec% > file.txt
goto main



  
:getTime
	:: https://stackoverflow.com/a/42199181/688352
	for /F "skip=1 usebackq delims=" %%A in (`wmic Path Win32_LocalTime Get Second`) do for /F "delims=" %%B in ("%%A") do set "second=%%A"
%endfunction%

:printTime
	echo the time is %~1 seconds
%endfunction%

