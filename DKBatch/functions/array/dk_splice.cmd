@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# array\dk_splice(array, start, deleteCount, item1, item2, /* …, */ itemN)
::#
::#    https://www.w3schools.com/js/js_array_methods.asp#mark_splice
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/splice
::#
:dk_splice
    call dk_debugFunc 2
 setlocal
 
    %dk_call% dk_todo "array\dk_splice"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_todo
%endfunction%
