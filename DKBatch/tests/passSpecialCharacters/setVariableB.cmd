@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


:setVariableB name value
::setlocal
	echo "setVariable_B %~1 '%~2'"

	set "temp=%~2"
	set "temp=%temp:^^=^%"
	set "%~1=%temp%"
	

	call echo setVariable OUTPUT: %~1 = "%%%~1%%"
setlocal enableDelayedExpansion
	
	echo setVariable_B OUTPUT: %~1 = '!%~1!'
%endfunction%
