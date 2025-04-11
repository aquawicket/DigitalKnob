@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%" (set "DKBATCH_FUNCTIONS_DIR_=../")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::################################################################################
::# String/split(string, separator)
::# String/split(string, separator, array:optional)
::#
::#	The split() method of String values takes a pattern and divides this string into an ordered list of substrings by searching for the pattern, 
::# puts these substrings into an array, and returns the array.
::#
::#	PARAMETERS
::#  separator
::# 	The pattern describing where each split should occur. Can be undefined, a string, or an object with a Symbol.split method — the typical example being a regular expression.
::# 	Omitting separator or passing undefined causes split() to return an array with the calling string as a single element. All values that are not undefined or objects with a
::# 	[Symbol.split]() method are coerced to strings.
::#   
::#  limit Optional
::#		A non-negative integer specifying a limit on the number of substrings to be included in the array. If provided, splits the string at each occurrence of the specified
::#		separator, but stops when limit entries have been placed in the array. Any leftover text is not included in the array at all.
::#
::#  Return value
::# 	If separator is a string, an Array of strings is returned, split at each point where the separator occurs in the given string.
::#		If separator is a regex, the returned Array also contains the captured groups for each separator match; see below for details. The capturing groups may be unmatched, 
::#		in which case they are undefined in the array.
::#
::#  REFERENCE
::#		https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/split
::#
:dk_split
setlocal
	%dk_call% dk_debugFunc 1 2
	
	set "str=%~1"
	set /a "n=0"
	:loop
	for /F "tokens=1* delims=;" %%a in ("%str%") do (
		rem echo dk_split[!n!] = %%a
		set "dk_split[!n!]=%%a"
		set "str=%%b"
		set /a "n+=1"
	)
	if defined str goto :loop
	
	:: Return the array to the calling scope
	set "currentScope=1"
	for /F "delims=" %%a in ('set dk_split[') do (
		if defined currentScope endlocal
		set "%%a"
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% String/dk_split "abc;123;def;456;ghi;789;jkl"
	%dk_call% dk_printVar dk_split
%endfunction%
