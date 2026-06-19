@echo off

:printAll
	if not exist 1_255.chr (
		call genAll
	)

	setlocal enableDelayedExpansion
	<1_255.chr set /p "chars="

	for /l %%N in (0 1 255) do (
		rem if %%N neq 26 (
			set char%%N=!chars:~%%N,1!
		rem	set "bytes=!bytes!!char%%N!"
		rem ) else (
		rem 	cmd /d /c copy /y nul + nul /a t2.tmp /a >nul
		rem 	<t2.tmp set /p "chr%%N="
		rem 	set "bytes=!bytes!!chr%%N!"
		rem )
	)

	::set codepage to 437
	for /f "tokens=*" %%a in ('chcp') do for %%b in (%%a) do set "cp=%%~nb"
	mode con cp select=437 >nul

	::### Print each character 1-255
	for /l %%i in (0 1 255) do (
	   (echo.char%%i = '!char%%i!')
	)

	::### Print All Characters in one variable
	echo bytes = '!bytes!'

	mode con cp select=%cp% >nul
	
	pause
exit /b 0