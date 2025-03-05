@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%" (set "DKBATCH_FUNCTIONS_DIR_=../../functions/")
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)



:setVariable name value
	endlocal
	::echo "setVariable %~1 '%~2'"
%DESTATE%
	set "temp=%~2"
	set "temp=%temp:^^=^%"
	set "%~1=%temp%"
	

	setlocal enableDelayedExpansion
	echo setVariable OUTPUT: %~1 = '!%~1!'
::%endfunction%
setlocal enableDelayedExpansion