@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%" set "DKBATCH_FUNCTIONS_DIR_=..\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# array\dk_flat(array depth)
::#
::#    The flat() method of Array instances creates a new array with all sub-array elements concatenated into it recursively up to the specified depth.
::#
::#    PARAMETERS
::#    depth :optional
::#        The depth level specifying how deep a nested array structure should be flattened. Defaults to 1.
::#
::#    RETURN VALUE
::#    A new array with the sub-array elements concatenated into it.
::#
::#    REFERENCE
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/flat
::#
:dk_flat
    call dk_debugFunc 2
 setlocal
 
    %dk_call% dk_todo "array\dk_flat"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% array\dk_flat "array" "depth"
%endfunction%