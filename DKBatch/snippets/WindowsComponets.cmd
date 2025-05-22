@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


:: Windows Features apps

:: list all compoents
dism /online /get-features /format:table

:: enable a component, replace <COMPONONT_NAME>
::dism /online /enable-feature /featurename:<COMPONENT_NAME>

:: disable a component, replace <COMPONONT_NAME>
::dism /online /disable-feature /featurename:<COMPONENT_NAME>
