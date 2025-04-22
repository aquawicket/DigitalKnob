@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# dk_decimalToAscii(decimal)
::#
::#	reference: https://www.ascii-code.com
::#
:dk_decimalToAscii
setlocal
	%dk_call% dk_debugFunc 1

	%dk_call% dk_decimalToHex %~1
	%dk_call% dk_hexToAscii %dk_decimalToHex%

	endlocal & set "dk_hexToAscii=%dk_hexToAscii%"
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_set myDecimal 123
	%dk_call% dk_decimalToAscii "%myDecimal%"
	%dk_call% dk_printVar dk_decimalToAscii
%endfunction%
