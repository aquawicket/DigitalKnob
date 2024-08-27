@echo off

::set "ENABLE_dk_debugFunc=1"	

::###### DK_INIT ######
set "DKHTTP_DK_CMD=https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBatch/functions/DK.cmd"
set "DKBATCH_FUNCTIONS_DIR=%CD%\DKBatch\functions"
set "DKBATCH_FUNCTIONS_DIR_=%DKBATCH_FUNCTIONS_DIR%\"
set "DK_CMD=%DKBATCH_FUNCTIONS_DIR%\DK.cmd"
if not exist "%DKBATCH_FUNCTIONS_DIR%" mkdir "%DKBATCH_FUNCTIONS_DIR%"
if not exist "%DK_CMD%" powershell /? 1>nul && powershell -command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DK_CMD%', '%DK_CMD%')"
if not exist "%DK_CMD%" curl --help 1>nul && curl "%DKHTTP_DK_CMD%" -o "%DK_CMD%"
if not exist "%DK_CMD%" certutil /? 1>nul && certutil -urlcache -split -f "%DKHTTP_DK_CMD%" "%DK_CMD%"
if not exist "%DK_CMD%" echo [31m ERROR: failed to download DK.cmd [0m
call "%DK_CMD%" %0

::################## DKBuilder ####################
%dk_call% dk_buildMain
