<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_decimalToAscii(<decimal> rtn_var)
::#
::#    reference: https://www.ascii-code.com
::#
:dk_decimalToAscii
    call dk_debugFunc 2
 setlocal
 
    %dk_call% dk_decimalToHex %~1 hex
    %dk_call% dk_hexToAscii %hex% ascii
    
    endlocal & set "%2=%ascii%"
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
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
>>>>>>> Development
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_set myDecimal 123
    %dk_call% dk_decimalToAscii "%myDecimal%" myAscii
    %dk_call% dk_printVar myAscii
=======
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_set myDecimal 123
	%dk_call% dk_decimalToAscii "%myDecimal%"
	%dk_call% dk_printVar dk_decimalToAscii
>>>>>>> Development
%endfunction%
