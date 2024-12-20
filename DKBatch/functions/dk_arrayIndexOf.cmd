@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_arrayIndexOf(array, searchElement)
::# dk_arrayIndexOf(array, searchElement, rtn_val)
::# dk_arrayIndexOf(array, searchElement, fromIndex)
::# dk_arrayIndexOf(array, searchElement, fromIndex, rtn_val)
::#
::#    The indexOf() method of Array instances returns the first index at which a given element can be found in the array, or -1 if it is not present.
::#
::#    PARAMETERS
::#    searchElement
::#        Element to locate in the array.
::#
::#    fromIndex :optional
::#        Zero-based index at which to start searching, converted to an integer.
::#            Negative index counts back from the end of the array — if -array.length <= fromIndex < 0, fromIndex + array.length is used. 
::#            Note, the array is still searched from front to back in this case.
::#            If fromIndex < -array.length or fromIndex is omitted, 0 is used, causing the entire array to be searched.
::#            If fromIndex >= array.length, the array is not searched and -1 is returned.
::#
::#    RETURN VALUE
::#    The first index of searchElement in the array; -1 if not found.
::#
::#    REFERENCE
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/indexOf
::#
:dk_arrayIndexOf
    call dk_debugFunc 3
 setlocal
 
    set _count_=0
    :dk_arrayIndexOf_loop
        if not defined %~1[%_count_%] (
            endlocal & %dk_call% dk_set %3 -1
            rem %return%
			goto end_arrayIndexOf
        )

        if "!DE!" equ "" set "_value_=!%~1[%_count_%]!"
        if "!DE!" neq "" call set "_value_=%%%~1[%_count_%]%%"
        if "%~2" == "%_value_%" (
            endlocal & set "%3=%_count_%"
            rem %return%
			goto end_arrayIndexOf
        )

        set /a _count_+=1
    goto dk_arrayIndexOf_loop

:end_arrayIndexOf
::debug
::	%dk_call% dk_printVar %3
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

    %dk_call% dk_arrayIndexOf myArrayA "a b c" indexABC
    %dk_call% dk_printVar indexABC

    %dk_call% dk_arrayIndexOf myArrayA "1 2 3" index123
    %dk_call% dk_printVar index123

    %dk_call% dk_arrayIndexOf myArrayA "d e f" indexDEF
    %dk_call% dk_printVar indexDEF

    %dk_call% dk_arrayIndexOf myArrayA "4 5 6" index456
    %dk_call% dk_printVar index456

    %dk_call% dk_arrayIndexOf myArrayA "h i j" indexGHI
    %dk_call% dk_printVar indexGHI

    %dk_call% dk_arrayIndexOf myArray "nonExistant" indexN
    %dk_call% dk_printVar indexN
%endfunction%
