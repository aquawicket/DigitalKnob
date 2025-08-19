@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


:Add3rdParty
	%dk_call% dk_inputBox
	
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	if EXIST "%DKIMPORTS_DIR%/%dk_inputBox%" (echo %dk_inputBox% already exists & %return%)
	
	echo creating %dk_inputBox% . . .
	%dk_call% dk_copy "%DKIMPORTS_DIR%/_TEMPLATE-LIB_" "%DKIMPORTS_DIR%/%dk_inputBox%"
%endfunction%