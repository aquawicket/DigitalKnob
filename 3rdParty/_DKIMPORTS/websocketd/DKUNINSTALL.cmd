@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::###### TEMPLATE ######
%dk_call% dk_getFileParams		"%~dp0/dkconfig.txt"
%dk_call% dk_importVariables	"%TEMPLATE_Import%"
%dk_call% dk_assertVar 			TEMPLATE

%dk_call% dk_delete "%TEMPLATE%"

