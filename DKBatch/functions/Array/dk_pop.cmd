@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# Array/dk_pop(array)
::#
::#	The pop() method of Array instances removes the last element from an array and returns that element. This method changes the length of the array
::#
::#	PARAMETERS
::#	array
::#
::#	RETURN VALUE
::#	The removed element from the array; undefined if the array is empty.
::#
::#	REFERENCE
::#	https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/pop
::#
:dk_pop
%setlocal%
	%dk_call% dk_debugFunc 1
	
	%dk_call% Array/dk_length %~1
	set /a dk_length-=1

	(set dk_pop=!%~1[%dk_length%]!)
	endlocal & (set dk_pop=%dk_pop%) & (set %~1[%dk_length%]=)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	set "myArrayA[0]=a b c"
	set "myArrayA[1]=1 2 3"
	set "myArrayA[2]=d e f"
	set "myArrayA[3]=4 5 6"
	set "myArrayA[4]=h i j"
	
	%dk_call% dk_printVar myArrayA
	%dk_call% dk_echo
	
	%dk_call% Array/dk_pop myArrayA
	%dk_call% dk_printVar myArrayA
	%dk_call% dk_printVar dk_pop
	%dk_call% dk_echo
	
	%dk_call% Array/dk_pop myArrayA
	%dk_call% dk_printVar myArrayA
	%dk_call% dk_printVar dk_pop
	%dk_call% dk_echo
	
	%dk_call% Array/dk_pop myArrayA
	%dk_call% dk_printVar myArrayA
	%dk_call% dk_printVar dk_pop
	%dk_call% dk_echo
	
	%dk_call% Array/dk_pop myArrayA
	%dk_call% dk_printVar myArrayA
	%dk_call% dk_printVar dk_pop
	%dk_call% dk_echo
	
	%dk_call% Array/dk_pop myArrayA
	%dk_call% dk_printVar myArrayA
	%dk_call% dk_printVar dk_pop
	%dk_call% dk_echo
	
::  FIXME:  out of array bounds from here on
::  %dk_call% Array/dk_pop myArrayA
::  %dk_call% dk_printVar myArrayA
::  %dk_call% dk_printVar dk_pop
	%dk_call% dk_echo
%endfunction%
