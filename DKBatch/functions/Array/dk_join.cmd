@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%" set "DKBATCH_FUNCTIONS_DIR_=..\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# Array::dk_join(array, separator, rtn_var)
::#
::#    The join() method of Array instances creates and returns a new string by concatenating all of the elements in this array, separated by commas or a specified separator string. 
::#    If the array has only one item, then that item will be returned without using the separator.
::#
::#    PARAMETERS
::#    separator :optional
::#        A string to separate each pair of adjacent elements of the array. If omitted, the array elements are separated with a comma (",").
::#
::#    RETURN VALUE
::#    A string with all array elements joined. If Array::length is 0, the empty string is returned.
::#
::#    REFERENCE
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/join
::#
:dk_join
    %dk_call% dk_debugFunc 3
 setlocal

    ::set "_arry_=%~1"
    ::set "_separator_=%~2"
    set _count_=0
    :join_loop
    if defined %~1[%_count_%] (
        if defined _string_ (
            if "!DE!" equ "" set "_string_=%_string_%%~2!%~1[%_count_%]!"
            if "!DE!" neq "" call set "_string_=%_string_%%~2%%%~1[%_count_%]%%"
        ) else (
            if "!DE!" equ "" set "_string_=!%~1[%_count_%]!"
            if "!DE!" neq "" call set "_string_=%%%~1[%_count_%]%%"
        )
        set /a _count_+=1
        goto join_loop
    )
    endlocal & set "%3=%_string_%"
	
::debug
::	%dk_call% dk_printVar %3
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

    %dk_call% Array::dk_join myArrayA ";" myStringA
    %dk_call% dk_info "myStringA = %myStringA%"


    set "myArrayB[0]=h i j"
    set "myArrayB[1]=4 5 6"
    set "myArrayB[2]=d e f"
    set "myArrayB[3]=1 2 3"
    set "myArrayB[4]=a b c"

    %dk_call% Array::dk_join myArrayB ";" myStringB
    ::myStringB=$(Array::dk_join myArrayB ",")
    %dk_call% dk_info "myStringB = %myStringB%"
%endfunction%
