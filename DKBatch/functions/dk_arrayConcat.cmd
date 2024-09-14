@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_arrayConcat(array, {value1, value2, /* …, */ valueN})
::# dk_arrayConcat(array, {value1, value2, /* …, */ valueN}, rtn_var)
::#
::#  Merge two or more arrays. This method does not change the existing arrays, but instead returns a new array.
::#
::#    PARAMETERS
::#    value1, …, valueN Optional
::#        Arrays and/or values to concatenate into a new array.
::#        If all valueN parameters are omitted, concat returns a shallow copy of the existing array on which it is called. See the description below for more details.
::#
::#    RETURN VALUE
::#    A new Array instance.
::#
::#    REFERENCE
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/concat
::#
:dk_arrayConcat
    call dk_debugFunc 2 3
:: setlocal

    set "_arrayA_=%~1"
    set "_arrayB_=%~2"
    set "_arrayC_=%~3"

    set /a countA=0
    set /a countB=0
    :dk_arrayConcat_loop1
    if defined %_arrayA_%[%countA%] (
        call set "%_arrayC_%[%countB%]=%%%_arrayA_%[%countA%]%%"  &:: FIXME: remove the need for call here
        set /a countA+=1
        set /a countB+=1
        goto:dk_arrayConcat_loop1
    )
    set /a countA=0
    :dk_arrayConcat_loop2
    if defined %_arrayB_%[%countA%] (
        call set "%_arrayC_%[%countB%]=%%%_arrayB_%[%countA%]%%"  &:: FIXME: remove the need for call here
        set /a countA+=1
        set /a countB+=1
        goto:dk_arrayConcat_loop2
    )

    ::### return value ###
    if "!DE!" neq "" endlocal & %dk_call% dk_set %3 "%_arrayC_%"
    if "!DE!" equ "" endlocal & set "%3=!_arrayC_!"
	
::debug
	%dk_call% dk_printVar %3
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    set "myArray1[0]=a b c"
    set "myArray1[1]=d e f"
    set "myArray1[2]=g h i"

    set "myArray2[0]=1 2 3"
    set "myArray2[1]=4 5 6"
    set "myArray2[2]=7 8 9"

    %dk_call% dk_arrayConcat myArray1 myArray2 myNewArrayA
    %dk_call% dk_printVar myNewArrayA

    if ^
    "%myNewArrayA[0]%" == "a b c" if ^
    "%myNewArrayA[1]%" == "d e f" if ^
    "%myNewArrayA[2]%" == "g h i" if ^
    "%myNewArrayA[3]%" == "1 2 3" if ^
    "%myNewArrayA[4]%" == "4 5 6" if ^
    "%myNewArrayA[5]%" == "7 8 9" %dk_call% dk_success "dk_arrayConcat succeeded"
%endfunction%
