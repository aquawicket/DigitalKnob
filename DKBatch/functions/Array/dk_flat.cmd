@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%" (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%../")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::################################################################################
::# Array/dk_flat(array, depth)
::#
::#	The flat() method of Array instances creates a new array with all sub-array elements concatenated into it recursively up to the specified depth.
::#
::#	PARAMETERS
::#	depth :optional
::#		The depth level specifying how deep a nested array structure should be flattened. Defaults to 1.
::#
::#	RETURN VALUE
::#	A new array with the sub-array elements concatenated into it.
::#
::#	REFERENCE
::#	https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/flat
::#
:dk_flat
setlocal
	%dk_call% dk_debugFunc 2

	%dk_call% dk_todo "Array/dk_flat"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% Array/dk_flat "array" "depth"
%endfunction%
