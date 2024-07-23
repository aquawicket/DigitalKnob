@echo off
setlocal enableDelayedExpansion
if "!!" neq "" echo "delayed expansion is required" && pause && exit 

set $time=0^&call:getTime
:main
	set /p sec=%$time:0=!second!%
	echo sec = '%sec%'

goto:main



  
:getTime
	:: https://stackoverflow.com/a/42199181/688352
	for /F "skip=1 usebackq delims=" %%A in (`wmic Path Win32_LocalTime Get Second`) do for /F "delims=" %%B in ("%%A") do (set "second=%%A")
goto:eof



