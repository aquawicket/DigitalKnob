@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%" (set "DKBATCH_FUNCTIONS_DIR_=../")
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::################################################################################
::# Array::dk_unshift(array, element)
::#
::#    Adds the specified elements to the beginning of an array and returns the new length of the array
::#
::#    PARAMETERS
::#    element1, …, elementN
::#    The elements to add to the front of the arr.
::#
::#    RETURN VALUE
::#    The new length property of the object upon which the method was called.
::#
::#    https://www.w3schools.com/js/js_array_methods.asp#mark_unshift
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/unshift
::#
:dk_unshift
::setlocal
    %dk_call% dk_debugFunc 2

    set "_arry_=%~1"
    %dk_call% Array::dk_length %~1
	set /a "dk_unshift=dk_length+1"
	
    set /a "prev=dk_length-1"
	
    :unshift_loop
    if %dk_length% gtr 0 (
        set "%_arry_%[%dk_length%]=!%_arry_%[%prev%]!"
        set /a dk_length-=1
        set /a prev-=1
        goto unshift_loop
    )
    endlocal & set "%~1[0]=%~2" & set "dk_unshift=%dk_unshift%"
	
::  DEBUG
::	%dk_call% dk_printVar %1
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_echo
    %dk_call% Array::dk_unshift myArrayA "a b c"
    %dk_call% dk_printVar myArrayA
    %dk_call% dk_printVar dk_unshift
    
    %dk_call% dk_echo
    %dk_call% Array::dk_unshift myArrayA "1 2 3"
    %dk_call% dk_printVar myArrayA
    %dk_call% dk_printVar dk_unshift
    
    %dk_call% dk_echo
    %dk_call% Array::dk_unshift myArrayA "d e f"
    %dk_call% dk_printVar myArrayA
    %dk_call% dk_printVar dk_unshift
    
    %dk_call% dk_echo
    %dk_call% Array::dk_unshift myArrayA "4 5 6"
    %dk_call% dk_printVar myArrayA
    %dk_call% dk_printVar dk_unshift
    
    %dk_call% dk_echo
    %dk_call% Array::dk_unshift myArrayA "h i j"
    %dk_call% dk_printVar myArrayA
    %dk_call% dk_printVar dk_unshift
%endfunction%
