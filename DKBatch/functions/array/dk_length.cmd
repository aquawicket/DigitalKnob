@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%" set "DKBATCH_FUNCTIONS_DIR_=..\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# array\dk_length(array)
::# array\dk_length(array rtn_var)
::#
::#    The length data property of an Array instance represents the number of elements in that array. 
::#    The value is an unsigned, 32-bit integer that is always numerically greater than the highest index in the array.
::#
::#    REFERENCE
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/length
::#
:dk_length
    call dk_debugFunc 2
 setlocal
 
    set _length_=0
    :array\dk_length_loop
    if defined %~1[%_length_%] ( 
       set /a _length_+=1
       goto array\dk_length_loop 
    )
    endlocal & set "%2=%_length_%"
	
::debug	
::	%dk_call% dk_printVar %2
%endfunction%

set "array\dk_length=%~f0"


::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    set "myArrayA[0]=a b c"
    set "myArrayA[1]=1 2 3"
    set "myArrayA[2]=d e f"
    set "myArrayA[3]=4 5 6"
    set "myArrayA[4]=h i j"
    
	
    %dk_call% array\dk_length myArrayA myArrayLengthA
    %dk_call% dk_debug "myArrayLengthA = %myArrayLengthA%"
%endfunction%