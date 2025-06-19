@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::###### 7z ######

::### INSTALL ###
%dk_call% dk_getFileParams	"%~dp0/dkconfig.txt"
%dk_call% dk_import			%7z_Import%
%dk_call% dk_assertVar 		7Z
%dk_call% dk_set 7ZA_EXE	"%7Z%/7za.exe"
%dk_call% dk_assertPath		7ZA_EXE
