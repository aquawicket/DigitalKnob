@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*

::################################################################################
::# dk_arrayPush(array, element1, element2, /* …, */ elementN)
::#
::#    The push() method of Array instances adds the specified elements to the end of an array and returns the new length of the array.
::#
::#    PARAMETERS
::#    element1, …, elementN
::#        The element(s) to add to the end of the array.
::#
::#    RETURN VALUE
::#    The new length property of the object upon which the method was called.
::#
::#    REFERENCE
::#    https://www.w3schools.com/js/js_array_methods.asp#mark_push
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/push
::#
:dk_arrayPush
    call dk_debugFunc 2 3
 setlocal

    %dk_call% dk_arrayLength %~1 end_index
    endlocal & set "%~1[%end_index%]=%~2"

:: debug
::	%dk_call% dk_printVar %1
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_arrayPush myArrayA "a b c"          &:: new_lengthA
    %dk_call% dk_printVar myArrayA
    :: dk_printVar new_lengthA
    %dk_call% dk_echo
    
    %dk_call% dk_arrayPush myArrayA "1 2 3" "d e f"  &:: new_lengthA
    %dk_call% dk_printVar myArrayA
    :: dk_printVar new_lengthA
    %dk_call% dk_echo
    
    %dk_call% dk_arrayPush myArrayA "4 5 6" "h i j"  &:: new_lengthA
    %dk_call% dk_printVar myArrayA
    :: dk_printVar new_lengthA
    %dk_call% dk_echo
%endfunction%
