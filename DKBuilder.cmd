@echo off
		
::################## DKBuilder ####################
::###### DK_INIT ######
set "DKHTTP_DKBATCH_FUNCTIONS_DIR=https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBatch/functions"
set "DKBATCH_DIR=%CD%\DKBatch"
set "DKBATCH_FUNCTIONS_DIR=%DKBATCH_DIR%\functions"
set "DKBATCH_FUNCTIONS_DIR_=%DKBATCH_DIR%\functions\"
if not exist "%DKBATCH_FUNCTIONS_DIR%" mkdir "%DKBATCH_FUNCTIONS_DIR%"
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" powershell /? && powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/DK.cmd', '%DKBATCH_FUNCTIONS_DIR_%DK.cmd')"
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" certutil /? && certutil -urlcache -split -f "%DKHTTP_DKBATCH_FUNCTIONS_DIR%/DK.cmd" "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::###### Load Main Program ######
call dk_source dk_buildMain
call dk_buildMain