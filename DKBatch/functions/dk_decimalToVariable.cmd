@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################################################################################
::# dk_decimalToVariable(decimal)
::#
:dk_decimalToVariable
setlocal
	%dk_call% dk_debugFunc 1

	%dk_call% dk_decimalToHex %~2
	%dk_call% dk_hexToVariable %~1 %dk_decimalToHex%
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	set "myDecimal=32"
	%dk_call% dk_decimalToVariable "%myDecimal%"
	%dk_call% dk_printVar dk_decimalToVariable
%endfunction%
