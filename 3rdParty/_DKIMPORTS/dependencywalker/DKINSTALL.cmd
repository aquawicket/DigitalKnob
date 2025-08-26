@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=C:\Users\Administrator/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL
::#
:DKINSTALL
%setlocal%
	%dk_call% dk_debugFunc 0 

	%dk_call% dk_import APP

%endfunction%

