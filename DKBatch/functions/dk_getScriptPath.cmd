@echo off
::if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::https://stackoverflow.com/a/43123617/688352

set "func=%~0"
for /F "delims=\" %%X in ("%func:*\=%") do set "func=%%X"
if ":" == "%func:~0,1%" ( goto %func% )


:: *** Get the filename of the caller of this script, needed for later restart
:dk_getScriptPath
(
    (goto) 2>nul
    setlocal DisableDelayedExpansion
    set "_returnVar=%~1"
    call set "_lastpath=%%~f0"
    call set "_lastargs=%%*"
    call "%~d0\:Step2\..%~pnx0" %*
    endlocal
)
%endfunction%

:: *** Get the filename/cmd-line of the caller of the script
:Step2
(
    (goto) 2>nul
    (goto) 2>nul
    (goto) 2>nul
    ::setlocal DisableDelayedExpansion
    set "_returnVar=%_returnVar%"   
    set "_lastpath=%_lastpath%"
    set "_lastargs=%_lastargs%"
    call set "_path=%%~f0"
    call set "_callerpath=%%_path:*%%~f0=%%"
    call set "_args=%%*"
    if defined _callerpath (
        set "_callertype=batch"
        call "%~d0\:Step3\..%~pnx0"
    ) else (
        set "_callertype=cmd-line"
        %ComSpec% /c "call "%~d0\:Step3\..%~pnx0" "
    )
    endlocal
)
%endfunction%

:: *** STEP3 Restart the requester batch, but jump to the label :dk_getScriptPath_return
:Step3
    call :dk_getScriptPath_return
%endfunction%

:: *** This uses the trick, that starting a batch without CALL will jump to the last used label
:dk_getScriptPath_return
    if "%_returnVar%" neq "" set "%_returnVar%=%_callerpath%"
    endlocal
    %_lastpath% %_lastargs%
%endfunction%   