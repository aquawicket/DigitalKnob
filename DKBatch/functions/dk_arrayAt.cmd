@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_arrayAt(array, index, rtn_var)
::#
::#    Takes an array instance with an integer value and returns the item at that index, 
::#    allowing for positive and negative integers. Negative integers count back from the last item in the array.  <-- TODO
::#
::#    PARAMETERS
::#    index
::#    Zero-based index of the array element to be returned, converted to an integer. Negative index counts back from the end of the array — if index < 0, index + array.length is accessed.
::#
::#    RETURN VALUE
::#    The element in the array matching the given index. Always returns undefined if index < -array.length or index >= array.length without attempting to access the corresponding property.
::#
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/at
::#
:dk_arrayAt
    call dk_debugFunc 3
 setlocal
 
    ::%dk_call% dk_validateArgs array int optional:rtn_var

    ::### return value ###
    ::if "!DE!" neq "" endlocal & %dk_call% dk_set %3 "%%%~1[%~2]%%"
    if "!DE!" neq "" endlocal & call set "%3=%%%~1[%~2]%%"
    if "!DE!" equ "" endlocal & set "%3=!%~1[%~2]!"

::debug
	%dk_call% dk_printVar %3
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    set "myArrayA[0]=a b c"
    set "myArrayA[1]=1 2 3"
    set "myArrayA[2]=d e f"
    set "myArrayA[3]=4 5 6"
    set "myArrayA[4]=h i j"
    %dk_call% dk_printVar myArrayA
    %dk_call% dk_arrayAt MyArrayA 2 arrayAtA
    %dk_call% dk_printVar arrayAtA
    %dk_call% dk_echo "dk_arrayAt(MyArrayA 2) = %arrayAtA%"
    if "%arrayAtA%" neq "d e f" %dk_call% dk_error "dk_arrayAt() failed"
    if "%arrayAtA%" equ "d e f" %dk_call% dk_success "dk_arrayAt() suceeded" 

    set "myArrayB[0]=h i j"
    set "myArrayB[1]=4 5 6"
    set "myArrayB[2]=d e f"
    set "myArrayB[3]=1 2 3"
    set "myArrayB[4]=a b c"
    %dk_call% dk_printVar myArrayB
    %dk_call% dk_arrayAt MyArrayB 3 arrayAtB
    %dk_call% dk_printVar arrayAtB
    %dk_call% dk_echo "dk_arrayAt(MyArrayB 3) = %arrayAtB%"
    if "%arrayAtB%" neq "1 2 3" %dk_call% dk_error "dk_arrayAt() failed"
    if "%arrayAtB%" equ "1 2 3" %dk_call% dk_success "dk_arrayAt() suceeded"
%endfunction%
