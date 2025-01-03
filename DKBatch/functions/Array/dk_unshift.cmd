@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%" set "DKBATCH_FUNCTIONS_DIR_=..\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# Array::dk_unshift(array, element)
::# Array::dk_unshift(array, element, rtn_var)
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
    %dk_call% dk_debugFunc 2 3
 ::setlocal
 
    set "_arry_=%~1"
    ::set "_element_=%~2"
    %dk_call% Array::dk_length %~1 count
    set /a "prev=count-1"
    
    :unshift_loop
    if %count% gtr 0 (
        rem if "!DE!" neq "" call set "%_arry_%[%count%]=%%%_arry_%[%prev%]%%" &:: FIXME: remove the need for call here
        if "!DE!" equ "" set "%_arry_%[%count%]=!%_arry_%[%prev%]!"
        set /a count-=1
        set /a prev-=1
        goto unshift_loop
    )
    endlocal & set "%~1[0]=%~2"
	
:: debug
::	%dk_call% dk_printVar %1
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_echo
    %dk_call% Array::dk_unshift myArrayA "a b c" ::new_lengthA
    %dk_call% dk_printVar myArrayA
    ::%dk_call% dk_printVar new_lengthA
    
    %dk_call% dk_echo
    %dk_call% Array::dk_unshift myArrayA "1 2 3" ::new_lengthA
    %dk_call% dk_printVar myArrayA
    ::%dk_call% dk_printVar new_lengthA
    
    %dk_call% dk_echo
    %dk_call% Array::dk_unshift myArrayA "d e f" ::new_lengthA
    %dk_call% dk_printVar myArrayA
    ::%dk_call% dk_printVar new_lengthA
    
    %dk_call% dk_echo
    %dk_call% Array::dk_unshift myArrayA "4 5 6" ::new_lengthA
    %dk_call% dk_printVar myArrayA
    ::%dk_call% dk_printVar new_lengthA
    
    %dk_call% dk_echo
    %dk_call% Array::dk_unshift myArrayA "h i j" ::new_lengthA
    %dk_call% dk_printVar myArrayA
    ::%dk_call% dk_printVar new_lengthA
%endfunction%
