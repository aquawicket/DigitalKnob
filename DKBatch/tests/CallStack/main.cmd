@echo off &::########################################## DigitalKnob DKBatch #######################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################



setlocal enableDelayedExpansion
::call dk_call %0

:main
	%dk_call% setGlobal globalVarA GLOBALA
	%dk_call% setGlobal globalVarB GLOBALB
	%dk_call% funcA A
	
pause
%endfunction%








