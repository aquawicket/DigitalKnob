@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::#########################################################################################################
::# dk_printSeconds()
::#
::#
:dk_printSeconds
	call dk_debugFunc 0
	
	for /f "tokens=1-3 delims=1234567890 " %%a in ("%time%") do set "delims=%%a%%b%%c" 
	for /f "tokens=1-4 delims=%delims%" %%A in ("%time%") do (set "hour=%%A" & set "minute=%%B" & set "second=%%C" & set "centisecond=%%D")
	
	
	echo %hour%:%minute%:%second%.%centisecond%
::	setlocal
::	set /a "cs=100%centisecond%%%100"
::	set /a "ss=100%second%%%100"
::	set /a "nn=100%minute%%%100"
::	set /a "hh=100%hour%%%100"
::
::	set /a "dd=dd-1"
::	set /a "mm=mm-1"
::	set /a "yy=yy-1970"
::	
::	set /a "CentiSeconds_cs=%cs%"
::	set /a "Seconds_ss=%ss%"
::	set /a "Minutes_ss=%nn%*60+%Seconds_ss%"
::	set /a "Hours_ss=%hh%*60*60+%Minutes_ss%"
::	set /a "Days_ss=%dd%*24*60*60+%Hours_ss%
::	set /a "Months_ss=(%mm%*304/10)*24*60*60+%Days_ss%"
::	set /a "Years_ss=(%yy%*12*304/10)*24*60*60+%Months_ss%"
::	if %Years_ss% gtr 99999999 set /a "Years_ss=Years_ss+2160000"
::	endlocal & set "%1=%Years_ss%" & set "%2=%CentiSeconds_cs%"
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_printSeconds
goto:eof
