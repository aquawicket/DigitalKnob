@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%" (set "DKBATCH_FUNCTIONS_DIR_=../")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::################################################################################
::# Array/dk_shift(array)
::#
::#  Removes the first element from an array and returns that removed element. 
::#	This method changes the length of the array
::#
::#	PARAMETERS
::#	array
::#
::#	RETURN VALUE
::#	The removed element from the array; undefined if the array is empty.
::#	
::#	REFERENCE
::#	https://www.w3schools.com/js/js_array_methods.asp#mark_shift
::#	https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/shift
::#
:dk_shift
::setlocal
	%dk_call% dk_debugFunc 1

	set "_arry_=%~1"
	set prev=0
	set count=1
	call set dk_shift=%%%_arry_%[0]%%

	:shift_loop
	if defined %_arry_%[%count%] (
		call set "%_arry_%[%prev%]=%%%_arry_%[%count%]%%"
		set /a count+=1
		set /a prev+=1
		goto shift_loop
	)
	endlocal & %dk_call% dk_unset %_arry_%[%prev%]
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	set "myArrayA[0]=a b c"
	set "myArrayA[1]=1 2 3"
	set "myArrayA[2]=d e f"
	set "myArrayA[3]=4 5 6"
	set "myArrayA[4]=h i j"

	%dk_call% dk_printVar myArrayA
	%dk_call% dk_echo

	%dk_call% Array/dk_shift myArrayA
	%dk_call% dk_printVar myArrayA
	%dk_call% dk_printVar dk_shift
	%dk_call% dk_echo

	%dk_call% Array/dk_shift myArrayA
	%dk_call% dk_printVar myArrayA
	%dk_call% dk_printVar dk_shift
	%dk_call% dk_echo

	%dk_call% Array/dk_shift myArrayA
	%dk_call% dk_printVar myArrayA
	%dk_call% dk_printVar dk_shift
	%dk_call% dk_echo

	%dk_call% Array/dk_shift myArrayA
	%dk_call% dk_printVar myArrayA
	%dk_call% dk_printVar dk_shift
	%dk_call% dk_echo

	%dk_call% Array/dk_shift myArrayA
	%dk_call% dk_printVar myArrayA
	%dk_call% dk_printVar dk_shift
	%dk_call% dk_echo

:: FIXME:  out of array bounds from here on
:: %dk_call% Array/dk_shift myArrayA
:: %dk_call% dk_printVar myArrayA
:: %dk_call% dk_printVar dk_shift
%endfunction%
