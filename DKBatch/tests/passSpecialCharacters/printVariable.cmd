@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%" (set "DKBATCH_FUNCTIONS_DIR_=../../functions/")
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

:printVariable
setlocal enableDelayedExpansion

	echo Received complex string: '!%~1!'
	
%endfunction%