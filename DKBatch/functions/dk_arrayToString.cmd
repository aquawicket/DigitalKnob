@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::################################################################################
::# dk_arrayToString(array rtn_var)
::#
::#   https://www.w3schools.com/js/js_array_methods.asp#mark_tostring
::#   https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/toString
::#
:dk_arrayToString
    call dk_debugFunc 2
 setlocal
 
    %dk_call% dk_arrayJoin %~1 "," arrayStr
    endlocal & set "%2=%arrayStr%"
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
    %dk_call% dk_arrayToString MyArrayA MyStringA
    %dk_call% dk_info "MyStringA = %MyStringA%"
%endfunction%
