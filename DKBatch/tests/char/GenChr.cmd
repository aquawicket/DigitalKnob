@echo off

  rem This code creates one single byte. Parameter: int 0-255
  rem Teamwork of carlos, penpen, aGerman, dbenham, bluesxman, sst
  rem Tested under Win2000, XP, Win7, Win8, Win10
  rem Fixed issue on environments with dbcs codepage

:GenChr 0-255  
	setlocal enableextensions

	for /f "tokens=*" %%a in ('chcp') do for %%b in (%%a) do set "cp=%%~nb"
	mode con cp select=437 >nul
	
	if %~1 neq 26  (type nul >%~1.tmp
		makecab /d compress=off /d reserveperdatablocksize=26 /d reserveperfoldersize=%~1 %~1.tmp %~1.chr >nul
		type %~1.chr | (
		(for /l %%N in (1 1 38) do pause)>nul&findstr "^">%~1.tmp)
		>nul cmd.exe /d /c copy /y %~1.tmp /a "%~1.chr" /b
		del %~1.tmp
	) else (
		cmd.exe /d /c copy /y nul + nul /a "%~1.chr" /a >nul
	)
	
	mode con cp select=%cp% >nul
exit /b 0