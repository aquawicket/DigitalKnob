@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


sc delete MapsBroker
sc delete lfsvc
schtasks /Change /TN "\Microsoft\Windows\Maps\MapsUpdateTask" /disable
schtasks /Change /TN "\Microsoft\Windows\Maps\MapsToastTask" /disable
