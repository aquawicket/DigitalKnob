@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_getUnixTime(rtnvar)
::#
::#    REFERENCE: https://ss64.com/nt/syntax-gettime.html
::#
:dk_getUnixTime
	call dk_debugFunc 1
	
	setlocal
	for /f %%x in ('wmic path win32_utctime get /format:list ^| findstr "="') do (set %%x)
	set /a z=(14-100%Month%%%100)/12, y=10000%Year%%%10000-z
	set /a ut=y*365+y/4-y/100+y/400+(153*(100%Month%%%100+12*z-3)+2)/5+Day-719469
	set /a ut=ut*86400+100%Hour%%%100*3600+100%Minute%%%100*60+100%Second%%%100
	endlocal & set "%1=%ut%"
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_getUnixTime unixTime
	echo unixTime = %unixTime%
goto:eof	