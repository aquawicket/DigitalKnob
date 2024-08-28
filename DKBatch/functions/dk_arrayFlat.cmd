@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::################################################################################
::# dk_arrayFlat(array depth)
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
:dk_arrayFlat
 setlocal
	call dk_debugFunc 2
	
	%dk_call% dk_todo "dk_arrayFlat"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_arrayFlat "array" "depth"
%endfunction%
