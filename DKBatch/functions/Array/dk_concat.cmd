@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################################################################################
::# Array/dk_concat(array, {value1, value2, /* …, */ valueN})
::#
::#  Merge two or more arrays. This method does not change the existing arrays, but instead returns a new array
::#
::#	PARAMETERS
::#	value1, …, valueN Optional
::#		Arrays and/or values to concatenate into a new array
::#		If all valueN parameters are omitted, concat returns a shallow copy of the existing array on which it is called. See the description below for more details.
::#
::#	RETURN VALUE
::#	A new Array instance.
::#
::#	REFERENCE
::#	https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/concat
::#
:dk_concat
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 2

	set "_arrayA_=%~1"
	set "_arrayB_=%~2"
	set "dk_concat=dk_concat"

	set /a "countA=0"
	set /a "countB=0"
	:concat_loop1
	if defined %_arrayA_%[%countA%] (
		set "%dk_concat%[%countB%]=!%_arrayA_%[%countA%]!"
		set /a "countA+=1"
		set /a "countB+=1"
		goto concat_loop1
	)
	set /a countA=0
	:concat_loop2
	if defined %_arrayB_%[%countA%] (
		set "%dk_concat%[%countB%]=!%_arrayB_%[%countA%]!"
		set /a "countA+=1"
		set /a "countB+=1"
		goto :concat_loop2
	)

	:: Return the array to the calling scope
	set "currentScope=1"
	for /F "delims=" %%a in ('set %dk_concat%[') do (
		if defined currentScope endlocal
		set "%%a"
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	set "myArray1[0]=a b c"
	set "myArray1[1]=d e f"
	set "myArray1[2]=g h i"
	%dk_call% dk_printVar myArray1

	echo:
	set "myArray2[0]=1 2 3"
	set "myArray2[1]=4 5 6"
	set "myArray2[2]=7 8 9"
	%dk_call% dk_printVar myArray2

	echo:
	%dk_call% Array/dk_concat myArray1 myArray2
	%dk_call% dk_printVar dk_concat

	echo:
	if ^
	"%dk_concat[0]%" equ "a b c" if ^
	"%dk_concat[1]%" equ "d e f" if ^
	"%dk_concat[2]%" equ "g h i" if ^
	"%dk_concat[3]%" equ "1 2 3" if ^
	"%dk_concat[4]%" equ "4 5 6" if ^
	"%dk_concat[5]%" equ "7 8 9" (
		%dk_call% dk_success "Array/dk_concat succeeded"
		%return%
	)
	
	%dk_call% dk_error "Array/dk_concat failed"
%endfunction%
