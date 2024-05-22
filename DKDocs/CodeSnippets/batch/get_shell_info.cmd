@echo off
:main
	call:print_shell_name
	pause
goto:eof

:print_shell_name
	echo %PSModulePath% | findstr %USERPROFILE% >NUL
	if %ERRORLEVEL% EQU 0 set "SHELL_NAME=powershell" & goto:done
	if "%MSYSTEM%" EQU "CLANG32" set "SHELL_NAME=clang32" & goto:done
	if "%MSYSTEM%" EQU "CLANG64" set "SHELL_NAME=clang64" & goto:done
	if "%MSYSTEM%" EQU "CLANGARM64" set "SHELL_NAME=clangarm64" & goto:done
	if "%MSYSTEM%" EQU "MINGW32" set "SHELL_NAME=mingw32" & goto:done
	if "%MSYSTEM%" EQU "MINGW64" set "SHELL_NAME=mingw64" & goto:done
	if "%MSYSTEM%" EQU "MSYS" set "SHELL_NAME=msys" & goto:done
	if "%MSYSTEM%" EQU "UCRT64" set "SHELL_NAME=uct64" & goto:done
	if "%SHELL_NAME%" EQU "" set "SHELL_NAME=cmd"
	
	:done
	echo SHELL_NAME = %SHELL_NAME%
goto:eof