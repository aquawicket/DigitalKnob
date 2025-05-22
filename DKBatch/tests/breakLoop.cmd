@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


:: https://stackoverflow.com/a/61752820/688352
echo Press Y to break
call:function

NEVER REACHED
exit /b %errorlevel%

:function
    echo Loop in progress...
    choice /C ny /T 1 /D n /N>x
    <x >nul 2>&1 call :checkify
goto:function


:: When a batch file is interrupted via Ctrl-C, AKA STATUS_CONTROL_C_EXIT, it returns ErrorLevel -1073741510 or ExitCode C000013A. We can take advantage of this.
:checkify
%ComSpec% /c exit -1073741510