@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################################################################################
::# Array/dk_copyWithin(array, target, start)
::# Array/dk_copyWithin(array, target, start, end)
::#
::#		The copyWithin() method of Array instances shallow copies part of this array to another location in the same array and returns this array without modifying its length.
::#
::#	PARAMETERS
::#	target
::#		Zero-based index at which to copy the sequence to, converted to an integer. This corresponds to where the element at start will be copied to, 
::#		and all elements between start and end are copied to succeeding indices.
::#			Negative index counts back from the end of the array — if -Array/length <= target < 0, target + Array/length is used.
::#			if target < -Array/length, 0 is used.
::#			if target >= Array/length, nothing is copied.
::#			if target is positioned after start after normalization, copying only happens until the end of Array/length (in other words, copyWithin() never extends the array).
::#	start
::#		Zero-based index at which to start copying elements from, converted to an integer.
::#			Negative index counts back from the end of the array — if -Array/length <= start < 0, start + Array/length is used.
::#			if start < -Array/length, 0 is used.
::#			if start >= Array/length, nothing is copied.
::#	end :optional
::#		Zero-based index at which to end copying elements from, converted to an integer. copyWithin() copies up to but not including end.
::#			Negative index counts back from the end of the array — if -Array/length <= end < 0, end + Array/length is used.
::#			if end < -Array/length, 0 is used.
::#			if end >= Array/length or end is omitted, Array/length is used, causing all elements until the end to be copied.
::#			if end implies a position before or at the position that start implies, nothing is copied.
::#
::#	RETURN VALUE
::#	The modified array
::#
::#	REFERENCE
::#	https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/copyWithin
::#
:dk_copyWithin
setlocal
	%dk_call% dk_debugFunc 3 4

	%dk_call% dk_todo "Array/dk_copyWithin"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% Array/dk_copyWithin array target start end
%endfunction%
