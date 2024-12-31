@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%" set "DKBATCH_FUNCTIONS_DIR_=..\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# Array::dk_slice(array, start, end)
::#
::#    The slice() method of Array instances returns a shallow copy of a portion of an array into a new array object selected from start to end (end not included) 
::#    where start and end represent the index of items in that array. The original array will not be modified.
::#
::#    PARAMETERS
::#    start :optional
::#        Zero-based index at which to start extraction, converted to an integer.
::#        Negative index counts back from the end of the array — if -Array::length <= start < 0, start + Array::length is used.
::#        If start < -Array::length or start is omitted, 0 is used.
::#        If start >= Array::length, an empty array is returned.
::#   
::#    end :optional
::#        Zero-based index at which to end extraction, converted to an integer. slice() extracts up to but not including end.
::#        Negative index counts back from the end of the array — if -Array::length <= end < 0, end + Array::length is used.
::#        If end < -Array::length, 0 is used.
::#        If end >= Array::length or end is omitted, Array::length is used, causing all elements until the end to be extracted.
::#        If end implies a position before or at the position that start implies, an empty array is returned.
::#
::#    RETURN VALUE
::#    A new array containing the extracted elements.
::#
::#    REFERENCE
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/slice
::#
:dk_slice
    %dk_call% dk_debugFunc 2
 setlocal
 
    %dk_call% dk_todo "Array::dk_slice"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    %dk_call% dk_debugFunc 0
 setlocal
 
    %dk_call% dk_todo
%endfunction%
