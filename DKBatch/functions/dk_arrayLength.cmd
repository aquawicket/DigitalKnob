@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::################################################################################
::# dk_arrayLength(array)
::# dk_arrayLength(array rtn_var)
::#
::#    The length data property of an Array instance represents the number of elements in that array. 
::#    The value is an unsigned, 32-bit integer that is always numerically greater than the highest index in the array.
::#
::#    REFERENCE
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/length
::#
:dk_arrayLength
    call dk_debugFunc 2
 setlocal
 
    set _length_=0
    :dk_arrayLength_loop
    if defined %~1[%_length_%] ( 
       set /a _length_+=1
       goto :dk_arrayLength_loop 
    )
    endlocal & set "%2=%_length_%"
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
    
    %dk_call% dk_arrayLength myArrayA myArrayLengthA
    %dk_call% dk_printVar myArrayLengthA
%endfunction%
