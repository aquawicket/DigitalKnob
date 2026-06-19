@echo off

:main
	call :charByChar "%~dp0\test.txt"

pause
exit /b


rem # charByChar("filepath")
:charByChar
	setlocal EnableDelayedExpansion

    echo.
	echo.############ %~n1 ############
	echo.### size %~z1
	
	echo.
	echo ### TYPE ###
	cmd /Q /U /C type "%~1"
	
	echo ### cmd type more ###
	cmd /Q /U /C type "%~1" | more
	

	echo ### type more ###
	
	
	
	for /F "delims=" %%a in ('cmd /U /C type "%~1" ^| more ^| find /V ""') do (set "TYPEMORE=!TYPEMORE!'%%a'")
	echo TYPEMORE = '%TYPEMORE%'
	
	echo.
	echo.
	set /P SETP= < "%~1"
	echo SETP = '%SETP%'
	
	set /A lineN=0, charN=0
	for /F "delims=" %%a in ('cmd /Q /U /C set /P "=!SETP!" ^< NUL ^| find /V ""') do (
	rem for /F "delims=" %%a in ('cmd /Q /U /C type "%~1" ^| find /N /V ""') do (
		echo '%%a'
		set /A charN+=1
		set "data=%%a"
		
		rem set char=!data:*]=!
		rem set fileData=!fileData!;!char:EMPTY!=!
		rem echo '!charN!: !char:EMPTY!=!'
	)
	
	echo.
	echo FILEDATA = %fileData%
exit /b
