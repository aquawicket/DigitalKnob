@echo off

:main
	for /l %%a in (1,1,255) do (
		call :printChr %%a
	)
	pause
exit /b 0


:printChr
	if not exist %~1.chr (
		call genChr.cmd %~1
	)

	setlocal enableDelayedExpansion
	<%~1.chr set /p "char%~1="

::	for /l %%N in (1 1 1) do (
::		rem if %%N neq 26 (
::			set char%%N=!chars:~%%N,1!
::		rem	set "bytes=!bytes!!char%%N!"
::		rem ) else (
::		rem 	cmd /d /c copy /y nul + nul /a t2.tmp /a >nul
::		rem 	<t2.tmp set /p "chr%%N="
::		rem 	set "bytes=!bytes!!chr%%N!"
::		rem )
::	)
	
	::set codepage to 437
	for /f "tokens=*" %%a in ('chcp') do for %%b in (%%a) do set "cp=%%~nb"
	mode con cp select=437 >nul


	::### Print chr
   (echo.char%~1 = '!char%~1!')





	mode con cp select=%cp% >nul

exit /b 0