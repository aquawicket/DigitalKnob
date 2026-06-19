@echo off

:main
setlocal enableDelayedExpansion
	for /l %%a in (0,1,255) do (
		call :printChr2 %%a
	)
	
	echo !char27![92m green !char27![0m
	pause
exit /b 0

:printChr2
setlocal enableDelayedExpansion
	if not exist 1_255.chr (
		call genAll
	)

	if not defined chars (
		<1_255.chr set /p "chars="
	)
	
	if not defined char%~1 (
		set char%~1=!chars:~%~1,1!
	)
	
::	for /l %%N in (0 1 255) do (
::		if not defined char%%N (
::			set char%%N=!chars:~%%N,1!
::		)
::	)

	::set codepage to 437
	for /f "tokens=*" %%a in ('chcp') do for %%b in (%%a) do set "cp=%%~nb"
	mode con cp select=437 >nul

	::### Print each character 1-255
::	for /l %%i in (0 1 255) do (
	   (echo.char%~1 = '!char%~1!')
::	)

	::### Print All Characters in one variable
::	echo bytes = '!bytes!'

	mode con cp select=%cp% >nul
	
	set char=!char%~1!
	endlocal & (
		set "char%~1=%char%"
	)
exit /b 0