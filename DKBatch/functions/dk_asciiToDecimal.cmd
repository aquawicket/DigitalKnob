@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# dk_asciiToDecimal(<ascii>, <rtn_var>:optional))
::#
::#	reference: https://www.ascii-code.com
::#
:dk_asciiToDecimal
%setlocal%
	%dk_call% dk_debugFunc 1 2

	%dk_call% dk_asciiToHex %~1
	%dk_call% dk_hexToDecimal %dk_asciiToHex%

	endlocal & (
		set "dk_asciiToDecimal=%dk_hexToDecimal%"
		if "%~2" neq "" (set "%~2=%dk_hexToDecimal%")
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_set myAscii a
	%dk_call% dk_asciiToDecimal %myAscii%
	%dk_call% dk_echo "'%myAscii%': dk_asciiToDecimal = %dk_asciiToDecimal%"

	%dk_call% dk_set myAscii b
	%dk_call% dk_asciiToDecimal %myAscii%
	%dk_call% dk_echo "'%myAscii%': dk_asciiToDecimal = %dk_asciiToDecimal%"

	%dk_call% dk_set myAscii c
	%dk_call% dk_asciiToDecimal %myAscii%
	%dk_call% dk_echo "'%myAscii%': dk_asciiToDecimal = %dk_asciiToDecimal%"
%endfunction%
