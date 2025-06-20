@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::###### TEMPLATE ######

%dk_call% dk_getFileParams	"%~dp0/dkconfig.txt"
%dk_call% dk_import			"%TEMPLATE_Import%"
%dk_call% dk_assertVar 		TEMPLATE

