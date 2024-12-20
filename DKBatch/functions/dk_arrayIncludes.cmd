if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_arrayIncludes(array, searchElement)
::# dk_arrayIncludes(array, searchElement, fromIndex)
::#
::#    The includes() method of Array instances determines whether an array includes a certain value among its entries, returning true or false as appropriate.
::#
::#    PARAMETERS
::#    searchElement
::#        The value to search for.
::#
::#    fromIndex :optional
::#        Zero-based index at which to start searching, converted to an integer.
::#            Negative index counts back from the end of the array — if -array.length <= fromIndex < 0, fromIndex + array.length is used. However, 
::#            the array is still searched from front to back in this case.
::#            If fromIndex < -array.length or fromIndex is omitted, 0 is used, causing the entire array to be searched.
::#            If fromIndex >= array.length, the array is not searched and false is returned.
::#
::#    RETURN VALUE
::#    A boolean value which is true if the value searchElement is found within the array (or the part of the array indicated by the index fromIndex, if specified).
::#
::#    REFERENCE
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/includes
::#
:dk_arrayIncludes
    call dk_debugFunc 2 3
 setlocal enableDelayedExpansion
 
    set "_arry_=%~1"
    set /a count=0
    :dk_arrayIncludes_loop
    if defined %_arry_%[%count%] (
        if "!%_arry_%[%count%]!" == "%~2" (
            if "%~3" neq "" (endlocal & set "%3=true")
            exit /b 0
        )
        set /a count+=1
        goto dk_arrayIncludes_loop
    )
    if "%~3" neq "" (endlocal & set "%3=false")
    exit /b 1
	
::debug
::	%dk_call% dk_printVar %3
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_echo
    set "array123[0]=1"
    set "array123[1]=2"
    set "array123[2]=3"
    %dk_call% dk_printVar array123
    %dk_call% dk_info "dk_arrayIncludes array123 2"
    %dk_call% dk_arrayIncludes array123 2      && echo true || echo false  &:: true
    %dk_call% dk_info "dk_arrayIncludes array123 4"
    %dk_call% dk_arrayIncludes array123 4      && echo true || echo false  &:: false
    ::%dk_call% dk_arrayIncludes array123 3 3  && echo true || echo false  &:: false
    ::%dk_call% dk_arrayIncludes array123 3 -1 && echo true || echo false  &:: true

    %dk_call% dk_echo
    set "array12NaN[0]=1"
    set "array12Nan[1]=2"
    set "array12Nan[2]=NaN"
    %dk_call% dk_printVar array12Nan
    %dk_call% dk_info "dk_arrayIncludes array12NaN NaN"
    %dk_call% dk_arrayIncludes array12NaN NaN  && echo true || echo false  &:: true

    %dk_call% dk_echo
    set "array123q[0]="1""
    set "array123q[1]="2""
    set "array123q[2]="3""
    %dk_call% dk_printVar array123q
    %dk_call% dk_info "dk_arrayIncludes array123q 3"
    %dk_call% dk_arrayIncludes array123q 3     && echo true || echo false  &::# false
%endfunction%
