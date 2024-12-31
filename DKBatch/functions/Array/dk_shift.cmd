@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%" set "DKBATCH_FUNCTIONS_DIR_=..\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# Array::dk_shift(array)
::# Array::dk_shift(array, rtn_var)
::#
::#  Removes the first element from an array and returns that removed element. 
::#    This method changes the length of the array
::#
::#    PARAMETERS
::#    array
::#
::#    RETURN VALUE
::#    The removed element from the array; undefined if the array is empty.
::#    
::#    REFERENCE
::#    https://www.w3schools.com/js/js_array_methods.asp#mark_shift
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/shift
::#
:dk_shift
    %dk_call% dk_debugFunc 1 2
 ::setlocal
    
    set "_arry_=%~1"
    set prev=0
    set count=1
    :shift_loop
    if defined %_arry_%[%count%] (
        call set "%_arry_%[%prev%]=%%%_arry_%[%count%]%%"  &:: FIXME: remove the need for call here
        set /a count+=1
        set /a prev+=1
        goto shift_loop
    )
    endlocal & %dk_call% dk_unset %_arry_%[%prev%]
    ::endlocal & set "%_arry_%[%prev%]="
	
:: debug
::	if defined _arry_ %dk_call% dk_printVar %_arry_%
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    %dk_call% dk_debugFunc 0
 setlocal
 
    set "myArrayA[0]=a b c"
    set "myArrayA[1]=1 2 3"
    set "myArrayA[2]=d e f"
    set "myArrayA[3]=4 5 6"
    set "myArrayA[4]=h i j"
    
    %dk_call% dk_printVar myArrayA
    %dk_call% dk_echo
    
    %dk_call% Array::dk_shift myArrayA removedA
    %dk_call% dk_printVar myArrayA
    %dk_call% dk_printVar removedA
    %dk_call% dk_echo
    
    %dk_call% Array::dk_shift myArrayA removedA
    %dk_call% dk_printVar myArrayA
    %dk_call% dk_printVar removedA
    %dk_call% dk_echo
    
    %dk_call% Array::dk_shift myArrayA removedA
    %dk_call% dk_printVar myArrayA
    %dk_call% dk_printVar removedA
    %dk_call% dk_echo
    
    %dk_call% Array::dk_shift myArrayA removedA
    %dk_call% dk_printVar myArrayA
    %dk_call% dk_printVar removedA
    %dk_call% dk_echo
    
    %dk_call% Array::dk_shift myArrayA removedA
    %dk_call% dk_printVar myArrayA
    %dk_call% dk_printVar removedA
    %dk_call% dk_echo
    
    :: FIXME:  out of array bounds past here
::  %dk_call% Array::dk_shift myArrayA removedA
::  %dk_call% dk_printVar myArrayA
::  %dk_call% dk_printVar removedA
    %dk_call% dk_echo
    %dk_call% dk_echo
%endfunction%
