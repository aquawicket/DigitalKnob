@echo off
::call DK

::https://stackoverflow.com/a/43123617/688352

::setlocal DisableDelayedExpansion
set "func=%~0"
for /F "delims=\" %%X in ("%func:*\=%") do set "func=%%X"
if ":" == "%func:~0,1%" ( goto %func% )

:: *** Get the filename of the caller of this script, needed for later restart
:Step1
(
    (goto) 2>nul
	
    ::setlocal DisableDelayedExpansion %= it could be reenabled by the GOTO =%
	set "_returnVar=%~1"
	call set "caller[0]=%%~0"
	call set "caller[0].fullpath=%%~f0"
	call set "caller[0].directory=%%~dp0"
	call set "caller[0].filename=%%~nx0"
	call set "caller[0].func=%%~n0"
	call set "caller[0].args=%%*"
	
	call set "_caller=%%caller[0].fullpath:*%%~f0=%%"
	if defined _caller (
        set "caller[0].type=batch"
        call "%~d0\:Step2\..%~pnx0" %*
    ) else (
        set "caller[0].type=cmd-line"
        cmd /c "call "%~d0\:Step2\..%~pnx0" %*"
    )
	endlocal
)
goto:eof


:: *** Get the caller of the this caller
:Step2
(
    (goto) 2>nul
    (goto) 2>nul
	
	::setlocal DisableDelayedExpansion %= it could be reenabled by the GOTO =% 
	set "_returnVar=%_returnVar%"
	set "caller[0]=%caller[0]%"
	set "caller[0].fullpath=%caller[0].fullpath%"
	set "caller[0].directory=%caller[0].directory%"
	set "caller[0].filename=%caller[0].filename%"
	set "caller[0].func=%caller[0].func%"
	set "caller[0].args=%caller[0].args%"
	
	call set "caller[1]=%%~0"
	call set "caller[1].fullpath=%%~f0"
	call set "caller[1].directory=%%~dp0"
	call set "caller[1].filename=%%~nx0"
	call set "caller[1].func=%%~n0"
	call set "caller[1].args=%%*"
	
	call set "_caller=%%caller[1].fullpath:*%%~f0=%%"
    if defined _caller (
        set "caller[1].type=batch"
        call "%~d0\:Step3\..%~pnx0" %*
    ) else (
        set "caller[1].type=cmd-line"
        cmd /c "call "%~d0\:Step3\..%~pnx0" %*"
    )
    endlocal
)
goto:eof


:: *** STEP3 Restart the requester batch, but jump to the label :dk_getCaller_return
:Step3
	::if "%_returnVar%" NEQ "" set "%_returnVar%=%caller[1]%"
	endlocal
	::echo _returnVar = %_returnVar%
	call :dk_getCaller_return%_returnVar%
	:dk_getCaller_return1
	%caller[0].fullpath% %caller[0].args%
goto:eof
