@echo off
(set LF=^
%= This creates a variable containing a single linefeed (0x0A) character =%
)
(set \n=^^^
%= This creates a variable containing a single linefeed (0x0A) character =%
)

setlocal disableDelayedExpansion
call :readFile %~dp0simpleFunc.cmd :simpleFunc
call %~dp0printMacro filedata

echo.
setlocal enableDelayedExpansion
call :readFile2 %~dp0simpleFunc.cmd :simpleFunc
call %~dp0printMacro filedata2
pause


:readFile file start_string
	set "filedata="
	set "read="
	<"%~1" (call :readLoop "%~2")
	exit /b
	:readLoop	
		set "line="
		set /p line=
		if "%line%" equ "%~1" set read=1
		if "%line%" equ "%~1_END" exit /b
		if "%read%" equ "1" (set filedata=%filedata%%line%!LF!)
		goto :readLoop
		exit /b
:readFile_END




:readFile2 file start_string
	set "filedata2="
	set "read2="
	<"%~1" (call :readLoop2 "%~2")
	exit /b
	:readLoop2	
		set "line2="
		set /p line2=
		if "%line2%" equ "%~1" set read2=1
		if "%line2%" equ "%~1_END" exit /b
		if "%read2%" equ "1" (set filedata2=!filedata2!%line2%!LF!)
		goto :readLoop2
		exit /b
:readFile2_END




