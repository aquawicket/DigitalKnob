@echo off
		
::################## DKBuilder ####################
::###### DK_INIT ######
set "DKHTTP_DKBATCH_FUNCTIONS_DIR=https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBatch/functions"
set "DKBATCH_DIR=%CD%\DKBatch"
set "DKBATCH_FUNCTIONS_DIR=%DKBATCH_DIR%\functions"
set "DKBATCH_FUNCTIONS_DIR_=%DKBATCH_DIR%\functions\"
if not exist "%DKBATCH_FUNCTIONS_DIR%" mkdir "%DKBATCH_FUNCTIONS_DIR%"
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/DK.cmd', '%DKBATCH_FUNCTIONS_DIR_%DK.cmd')"
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0


echo Press Y to break
call:function

NEVER REACHED
exit /b

:function
REM WORKS inside cached command block!

FOR /L %%G IN (0) DO (
	echo Loop still in progress...
	choice /C ny /T 1 /D n /N>x
	<x >nul 2>&1 call :checkify
)
    



:checkify
cmd /c exit -1073741510