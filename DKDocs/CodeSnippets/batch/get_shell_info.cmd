@echo off
:main
	call:print_shell_name
	pause
goto:eof

:print_shell_name
	echo %PSModulePath% | findstr %USERPROFILE% >NUL
	if %ERRORLEVEL% equ 0 set "SHELL_NAME=powershell" & goto:done
	if "%MSYSTEM%" equ "CLANG32" set "SHELL_NAME=clang32" & goto:done
	if "%MSYSTEM%" equ "CLANG64" set "SHELL_NAME=clang64" & goto:done
	if "%MSYSTEM%" equ "CLANGARM64" set "SHELL_NAME=clangarm64" & goto:done
	if "%MSYSTEM%" equ "MINGW32" set "SHELL_NAME=mingw32" & goto:done
	if "%MSYSTEM%" equ "MINGW64" set "SHELL_NAME=mingw64" & goto:done
	if "%MSYSTEM%" equ "MSYS" set "SHELL_NAME=msys" & goto:done
	if "%MSYSTEM%" equ "UCRT64" set "SHELL_NAME=uct64" & goto:done
	if "%SHELL_NAME%" equ "" set "SHELL_NAME=cmd"
	
	:done
	echo SHELL_NAME = %SHELL_NAME%
goto:eof