@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################################################################################
::# Array/dk_splice(array, start, deleteCount, item1, item2, /* …, */ itemN)
::#
::#	https://www.w3schools.com/js/js_array_methods.asp#mark_splice
::#	https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/splice
::#
:dk_splice
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_todo "Array/dk_splice"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_splice
%endfunction%
