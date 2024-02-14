@echo off
:main
	call:print_shell_name
	pause
goto:eof

:print_shell_name
	echo %PSModulePath% | findstr %USERPROFILE% >NUL
	if %ERRORLEVEL% EQU 0 set "SHELL_NAME=powershell"
	if "%MSYSTEM%" EQU "MINGW32" set "SHELL_NAME=mingw32"
	if "%MSYSTEM%" EQU "MINGW64" set "SHELL_NAME=mingw64"
	if "%SHELL_NAME%" EQU "" set "SHELL_NAME=cmd"
	echo SHELL_NAME = %SHELL_NAME%
goto:eof