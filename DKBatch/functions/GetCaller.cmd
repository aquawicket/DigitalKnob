::https://stackoverflow.com/a/43123617/688352
@echo off
::echo GetCaller.cmd

::setlocal DisableDelayedExpansion
set "func=%~0"
for /F "delims=\" %%X in ("%func:*\=%") do set "func=%%X"
if ":" == "%func:~0,1%" (
    goto %func%
)

:Step1
::echo GetCaller.cmd: STEP1
REM *** Get the filename of the caller of this script, needed for later restart
(
    (goto) 2>nul
    ::setlocal DisableDelayedExpansion %= it could be reenabled by the GOTO =%
    set "_returnVar=%~1"
    call set "_lastCaller=%%~f0"
    call set "_argToLastCaller=%%*"
    call "%~d0\:Step2\..%~pnx0" %*
	endlocal
)
exit /b %= This is never reached =%

:Step2
::echo GetCaller.cmd: STEP2
REM *** Get the filename/cmd-line of the caller of the script
(
    (goto) 2>nul
    (goto) 2>nul
    ::setlocal DisableDelayedExpansion %= it could be reenabled by the GOTO =%    
    set "_returnVar=%_returnVar%"
    set "_lastCaller=%_lastCaller%"
    set "_argToLastCaller=%_argToLastCaller%"
    call set "caller=%%~f0"
    call set _caller=%%caller:*%%~f0=%%
    if defined _caller (
        set "callType=batch"
        call "%~d0\:Step3batch\..%~pnx0"
    ) ELSE (
        set "callType=cmd-line"
        cmd /c "call "%~d0\:Step3batch\..%~pnx0" "
    )
    endlocal
)
exit /b %= This is never reached =%


:Step3batch
	::echo GetCaller.cmd: STEP3
	REM *** STEP3 Restart the requester batch, but jump to the label :GetCaller
	
	call :GetCaller
exit /b %= This is never reached =%


:GetCaller
	::echo GetCaller.cmd: :GetCaller
	REM *** This uses the trick, that starting a batch without CALL will jump to the last used label

	if "%_returnVar%" NEQ "" set "%_returnVar%=%_caller%"
	
	::echo caller = %caller%
	::echo callType = %callType%
	::echo func = %func%
	::echo _caller = %_caller%
	::echo _returnVar = %_returnVar%
	::echo _lastCaller = %_lastCaller%
	::echo _argToLastCaller = %_argToLastCaller%

	set "caller="
	set "callType="
	set "func="
	set "_caller="
	set "_returnVar="
	::set "_lastCaller="
	::set "_argToLastCaller="

	endlocal 
	%_lastCaller% %_argToLastCaller%
	
echo #6 never reached



