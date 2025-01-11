@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%" set "DKBATCH_FUNCTIONS_DIR_=..\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# Array::dk_indexOf(array, searchElement)
::# Array::dk_indexOf(array, searchElement, rtn_val)
::# Array::dk_indexOf(array, searchElement, fromIndex)
::# Array::dk_indexOf(array, searchElement, fromIndex, rtn_val)
::#
::#    The indexOf() method of Array instances returns the first index at which a given element can be found in the array, or -1 if it is not present.
::#
::#    PARAMETERS
::#    searchElement
::#        Element to locate in the array
::#
::#    fromIndex :optional
::#        Zero-based index at which to start searching, converted to an integer.
::#            Negative index counts back from the end of the array — if -Array::length <= fromIndex < 0, fromIndex + Array::length is used. 
::#            Note, the array is still searched from front to back in this case.
::#            If fromIndex < -Array::length or fromIndex is omitted, 0 is used, causing the entire array to be searched.
::#            If fromIndex >= Array::length, the array is not searched and -1 is returned.
::#
::#    RETURN VALUE
::#    The first index of searchElement in the array; -1 if not found.
::#
::#    REFERENCE
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/indexOf
::#
:dk_indexOf
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 2
	
    set "_count_=0"
    :indexOf_loop
        if not defined %~1[%_count_%] (
            endlocal & %dk_call% dk_set dk_indexOf -1
			%endfunction%
        )

        if "!DE!" equ "" set "_value_=!%~1[%_count_%]!"
        if "!DE!" neq "" call set "_value_=%%%~1[%_count_%]%%"
        if "%~2" == "%_value_%" (
            endlocal & set "dk_indexOf=%_count_%"
			%endfunction%
        )

        set /a "_count_+=1"
    goto indexOf_loop

:: DEBUG
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
	 %dk_call% dk_printVar myArrayA

    %dk_call% Array::dk_indexOf myArrayA "a b c"
    %dk_call% dk_echo "index of 'a b c' = %dk_indexOf%"

    %dk_call% Array::dk_indexOf myArrayA "1 2 3"
    %dk_call% dk_echo "index of '1 2 3' = %dk_indexOf%"

    %dk_call% Array::dk_indexOf myArrayA "d e f"
     %dk_call% dk_echo "index of 'd e f' = %dk_indexOf%"

    %dk_call% Array::dk_indexOf myArrayA "4 5 6"
    %dk_call% dk_echo "index of '4 5 6' = %dk_indexOf%"

    %dk_call% Array::dk_indexOf myArrayA "h i j"
     %dk_call% dk_echo "index of 'h i j' = %dk_indexOf%"

    %dk_call% Array::dk_indexOf myArray "nonExistant"
     %dk_call% dk_echo "index of 'nonExistant' = %dk_indexOf%"
%endfunction%
