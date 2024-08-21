@echo off
:main
	call:print_shellName
	call:print_shellPath
	pause
goto:eof

:print_shellName
	echo %PSModulePath% | findstr %USERPROFILE% >NUL
	if %ERRORLEVEL% equ 0 set "DKSHELL=powershell" & goto:done
	if "%MSYSTEM%" equ "CLANG32" set "DKSHELL=clang32" & goto:done
	if "%MSYSTEM%" equ "CLANG64" set "DKSHELL=clang64" & goto:done
	if "%MSYSTEM%" equ "CLANGARM64" set "DKSHELL=clangarm64" & goto:done
	if "%MSYSTEM%" equ "MINGW32" set "DKSHELL=mingw32" & goto:done
	if "%MSYSTEM%" equ "MINGW64" set "DKSHELL=mingw64" & goto:done
	if "%MSYSTEM%" equ "MSYS" set "DKSHELL=msys" & goto:done
	if "%MSYSTEM%" equ "UCRT64" set "DKSHELL=uct64" & goto:done
	for %%Z in ("%ComSpec%") do set "DKSHELL=%%~nZ"
	:done
	echo DKSHELL = %DKSHELL%
goto:eof

:print_shellPath
	if "%DKSHELL%"=="powershell" call :print_powershellPath

	echo DKSHELL_PATH = %DKSHELL_PATH%
goto:eof

:print_powershellPath
	::FOR /F "tokens=* USEBACKQ" %%F IN (`"(Get-Process -Id $pid).Path"`) DO (
	FOR /F "tokens=* USEBACKQ" %%F IN (`where powershell.exe`) DO (
		SET DKSHELL_PATH=%%F
	)
goto:eof