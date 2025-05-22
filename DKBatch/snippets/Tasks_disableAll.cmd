@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


for /f "tokens=1 delims=," %%a in (
    'schtasks /Query /FO csv ^| find /V "Task name" ^| find /V "Disabled"'
) do (
	echo %%a
	schtasks /change /tn %%a /disable
)