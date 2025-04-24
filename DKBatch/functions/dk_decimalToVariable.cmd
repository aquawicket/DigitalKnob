<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_decimalToVariable(<decimal> rtn_var)
::#
:dk_decimalToVariable
    call dk_debugFunc 2
 setlocal
 
    %dk_call% dk_decimalToHex %~2 hex
    %dk_call% dk_hexToVariable %~1 %hex%
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
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
>>>>>>> Development
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
    set "myDecimal=32"
    %dk_call% dk_decimalToVariable "%myDecimal%" myVariable
    %dk_call% dk_printVar myVariable
=======
setlocal
	%dk_call% dk_debugFunc 0

	set "myDecimal=32"
	%dk_call% dk_decimalToVariable "%myDecimal%"
	%dk_call% dk_printVar dk_decimalToVariable
>>>>>>> Development
%endfunction%
