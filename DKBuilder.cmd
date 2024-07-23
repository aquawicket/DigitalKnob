@echo off
	
set "ENABLE_dk_debugFunc=1"	
::################## DKBuilder ####################
::###### DK_INIT ######
set "DKHTTP_DKBATCH_FUNCTIONS_DIR=https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBatch/functions"
set "DKBATCH_DIR=%CD%\DKBatch"
set "DKBATCH_FUNCTIONS_DIR=%DKBATCH_DIR%\functions"
set "DKBATCH_FUNCTIONS_DIR_=%DKBATCH_FUNCTIONS_DIR%\"
if not exist "%DKBATCH_FUNCTIONS_DIR%" mkdir "%DKBATCH_FUNCTIONS_DIR%"
if not exist "%DKBATCH_FUNCTIONS_DIR%\DK.cmd" powershell /? 1>nul && powershell -command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/DK.cmd', '%DKBATCH_FUNCTIONS_DIR%/DK.cmd')"
if not exist "%DKBATCH_FUNCTIONS_DIR%\DK.cmd" curl --help 1>nul && curl %DKHTTP_DKBATCH_FUNCTIONS_DIR%/DK.cmd -o %DKBATCH_FUNCTIONS_DIR%/DK.cmd
if not exist "%DKBATCH_FUNCTIONS_DIR%\DK.cmd" certutil /? 1>nul && certutil -urlcache -split -f "%DKHTTP_DKBATCH_FUNCTIONS_DIR%/DK.cmd" "%DKBATCH_FUNCTIONS_DIR%/DK.cmd"
call "%DKBATCH_FUNCTIONS_DIR%\DK.cmd" %0

::###### Load Main Program ######
call dk_source dk_buildMain
call dk_buildMain