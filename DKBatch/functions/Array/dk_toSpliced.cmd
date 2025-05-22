@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# Array/dk_toSpliced(array, start, deleteCount, item1, item2, /* …, */ itemN)
::#
::#	https://www.w3schools.com/js/js_array_methods.asp#mark_tospliced
::#	https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/toSpliced
::#
:dk_toSpliced
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_todo "Array/dk_toSpliced"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_toSpliced
%endfunction%
