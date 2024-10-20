@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_arraySlice(array, start, end)
::#
::#    The slice() method of Array instances returns a shallow copy of a portion of an array into a new array object selected from start to end (end not included) 
::#    where start and end represent the index of items in that array. The original array will not be modified.
::#
::#    PARAMETERS
::#    start :optional
::#        Zero-based index at which to start extraction, converted to an integer.
::#        Negative index counts back from the end of the array — if -array.length <= start < 0, start + array.length is used.
::#        If start < -array.length or start is omitted, 0 is used.
::#        If start >= array.length, an empty array is returned.
::#   
::#    end :optional
::#        Zero-based index at which to end extraction, converted to an integer. slice() extracts up to but not including end.
::#        Negative index counts back from the end of the array — if -array.length <= end < 0, end + array.length is used.
::#        If end < -array.length, 0 is used.
::#        If end >= array.length or end is omitted, array.length is used, causing all elements until the end to be extracted.
::#        If end implies a position before or at the position that start implies, an empty array is returned.
::#
::#    RETURN VALUE
::#    A new array containing the extracted elements.
::#
::#    REFERENCE
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/slice
::#
:dk_arraySlice
    call dk_debugFunc 2
 setlocal
 
    %dk_call% dk_todo "dk_arraySlice"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_todo
%endfunction%
