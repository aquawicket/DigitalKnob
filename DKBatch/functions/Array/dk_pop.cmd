@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%" set "DKBATCH_FUNCTIONS_DIR_=..\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# Array::dk_pop(array)
::# Array::dk_pop(array, rtn_var)
::#
::#    The pop() method of Array instances removes the last element from an array and returns that element. This method changes the length of the array
::#
::#    PARAMETERS
::#    array
::#
::#    RETURN VALUE
::#    The removed element from the array; undefined if the array is empty.
::#
::#    REFERENCE
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/pop
::#
:dk_pop
    call dk_debugFunc 1 2
 setlocal
    
    %dk_call% Array::dk_length %~1 _length_
    set /a _length_-=1
    set "removedElement=!%~1[%_length_%]!"
    endlocal & set "%~2=%removedElement%" & %dk_call% dk_unset %~1[%_length_%]

::debug
::	%dk_call% dk_printVar %2
::	%dk_call% dk_printVar %1
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 ::setlocal
 
    set "myArrayA[0]=a b c"
    set "myArrayA[1]=1 2 3"
    set "myArrayA[2]=d e f"
    set "myArrayA[3]=4 5 6"
    set "myArrayA[4]=h i j"
    
    %dk_call% dk_printVar myArrayA 
    %dk_call% dk_echo
    
    %dk_call% Array::dk_pop myArrayA removedA
    %dk_call% dk_printVar myArrayA
    %dk_call% dk_printVar removedA
    %dk_call% dk_echo
    
    %dk_call% Array::dk_pop myArrayA removedA
    %dk_call% dk_printVar myArrayA
    %dk_call% dk_printVar removedA
    %dk_call% dk_echo
    
    %dk_call% Array::dk_pop myArrayA removedA
    %dk_call% dk_printVar myArrayA
    %dk_call% dk_printVar removedA
    %dk_call% dk_echo
    
    %dk_call% Array::dk_pop myArrayA removedA
    %dk_call% dk_printVar myArrayA
    %dk_call% dk_printVar removedA
    %dk_call% dk_echo
    
    %dk_call% Array::dk_pop myArrayA removedA
    %dk_call% dk_printVar myArrayA
    %dk_call% dk_printVar removedA
    %dk_call% dk_echo
    
::  FIXME:  out of array bounds past here
::  %dk_call% Array::dk_pop myArrayA removedA
::  %dk_call% dk_printVar myArrayA
::  %dk_call% dk_printVar removedA
    %dk_call% dk_echo
    %dk_call% dk_echo
%endfunction%
