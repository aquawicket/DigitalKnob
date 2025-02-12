@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%" (set "DKBATCH_FUNCTIONS_DIR_=..\")
if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::################################################################################
::# Array::dk_push(array, element1, element2, /* …, */ elementN)
::#
::#    The push() method of Array instances adds the specified elements to the end of an array and returns the new length of the array
::#
::#    PARAMETERS
::#    element1, …, elementN
::#        The element(s) to add to the end of the array
::#
::#    RETURN VALUE
::#    The new length property of the object upon which the method was called.
::#
::#    REFERENCE
::#    https://www.w3schools.com/js/js_array_methods.asp#mark_push
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/push
::#
:dk_push
setlocal
	%dk_call% dk_debugFunc 2

    %dk_call% Array::dk_length %~1
	(set /a dk_push=dk_length+1)
    endlocal & (set "%~1[%dk_length%]=%~2") & (set /a dk_push=%dk_push%)

::	DEBUG
::	%dk_call% dk_printVar %1
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% Array::dk_push myArrayA "a b c"
    %dk_call% dk_printVar myArrayA
    %dk_call% dk_printVar dk_push
    echo:
    
    %dk_call% Array::dk_push myArrayA "1 2 3" "d e f"
    %dk_call% dk_printVar myArrayA
    %dk_call% dk_printVar dk_push
    echo:
    
    %dk_call% Array::dk_push myArrayA "4 5 6" "h i j"
    %dk_call% dk_printVar myArrayA
    %dk_call% dk_printVar dk_push
    echo:
%endfunction%
