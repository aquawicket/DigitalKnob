:: https://stackoverflow.com/a/61752820/688352

@echo off
echo Press Y to break
call:function

NEVER REACHED
exit /b

:function
REM WORKS inside cached command block!
(
    echo Loop still in progress...
    choice /C ny /T 1 /D n /N>x
    <x >nul 2>&1 call :checkify
)
goto:function


:: When a batch file is interrupted via Ctrl-C, AKA STATUS_CONTROL_C_EXIT, it returns ErrorLevel -1073741510 or ExitCode C000013A. We can take advantage of this.
:checkify
cmd /c exit -1073741510