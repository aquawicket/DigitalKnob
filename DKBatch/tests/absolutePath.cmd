@echo off

set "PATH="
set "PATHEXT="

:main
setlocal EnableDelayedExpansion
	call :dk_absolutePath "..\"
	echo %dk_absolutePath_1% = %dk_absolutePath%
	
	call :dk_absolutePath "cmd.exe"
	echo %dk_absolutePath_1% = %dk_absolutePath%
	
	call :dk_absolutePath "curl.exe"
	echo %dk_absolutePath_1% = %dk_absolutePath%
	
	call :dk_absolutePath "C:\Users\Administrator\Desktop"
	echo %dk_absolutePath_1% = %dk_absolutePath%
	
	call :dk_absolutePath "winget.exe"
	echo %dk_absolutePath_1% = %dk_absolutePath%
	
	pause
exit /b %errorlevel%



:dk_absolutePath path
	set "dk_absolutePath_1=%~1"
	set "dk_absolutePath="
::	if EXIST "%~1"          (set dk_absolutePath=%~1		& exit /b %errorlevel%)
	if EXIST "%~dpnx1"         (set "dk_absolutePath=%~dpnx1"		& goto:return)
	for %%X in (%PATHEXT%) do (
		if EXIST "%~1%%X"       (set "dk_absolutePath=%~f1%%X"	& goto:return)
	)
	if EXIST "%~$PATH:1"    (set "dk_absolutePath=%~$PATH:1"	& goto:return)
	for %%X in (%PATHEXT%) do (
		for %%N in (%~1%%X) do (
			if EXIST "%%~$PATH:N"   (set "dk_absolutePath=%%~$PATH:N"	& goto:return)
		)
	)
	
	:return
	for %%a in ("%dk_absolutePath%") do (
		set "dk_absolutePath=%%~dpnxa"
	)
	
	
	if not defined dk_absolutePath (
		echo searching for %~nx1 . . .
		for /F "tokens=*" %%G IN ('dir /B /S "%USERPROFILE%\%~nx1"') do (
			echo %%~dpnxG
			set "dk_absolutePath=%%~dpnxG"
			goto:end_search
		)
	)
	:end_search
	
	for %%i in ("%dk_absolutePath%") do set attribute=%%~ai
	set attribute=%attribute:~8,1%
	if "%attribute%" == "l" (
		echo It's a symlink!
	) 
::	else (
::		echo It's real!
::	)
exit /b %errorlevel%

