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
	call set "_lastpath=%%~f0"
	call set "_lastcallerpath=%%_lastpath:*%%~f0=%%"
	call set "_lastfilename=%%~nx0"
	call set "_lastfunc=%%~n0"
	call set "_lastargs=%%*"

    call "%~d0\:Step2\..%~pnx0" %*
	endlocal
)
goto:eof


:: *** Get the filename/cmd-line of the caller of the script
:Step2
(
    (goto) 2>nul
    (goto) 2>nul
	
	::setlocal DisableDelayedExpansion %= it could be reenabled by the GOTO =% 
	set "_returnVar=%_returnVar%"	
	set "_lastpath=%_lastpath%"
	set "_lastcallerpath=%_lastcallerpath%"
	set "_lastfilename=%_lastfilename%"
	set "_lastfunc=%_lastfunc%"
	set "_lastargs=%_lastargs%"
	
	call set "_path=%%~f0"
	call set "_callerpath=%%_path:*%%~f0=%%"
	call set "_filename=%%~nx0"
	call set "_func=%%~n0"
	call set "_args=%%*"

    if defined _callerpath (
        set "_callertype=batch"
        call "%~d0\:Step3\..%~pnx0"
    ) else (
        set "_callertype=cmd-line"
        cmd /c "call "%~d0\:Step3\..%~pnx0" "
    )
    endlocal
)
goto:eof



:: *** STEP3 Restart the requester batch, but jump to the label :dk_caller
:Step3
	call :dk_caller
goto:eof




:: *** This uses the trick, that starting a batch without CALL will jump to the last used label
:dk_caller
	if "%_returnVar%" NEQ "" set "%_returnVar%=%_callerpath%"
	endlocal
	%_lastpath% %_lastargs%
goto:eof	