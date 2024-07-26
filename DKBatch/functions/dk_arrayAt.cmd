@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_arrayAt(array, index)
::# dk_arrayAt(array, index, rtn_var)
::#
::#	 Takes an array instance with an integer value and returns the item at that index, 
::#	 allowing for positive and negative integers. Negative integers count back from the last item in the array.  <-- TODO
::#
::#    PARAMETERS
::#    index
::#    Zero-based index of the array element to be returned, converted to an integer. Negative index counts back from the end of the array — if index < 0, index + array.length is accessed.
::#
::#    RETURN VALUE
::#    The element in the array matching the given index. Always returns undefined if index < -array.length or index >= array.length without attempting to access the corresponding property.
::#
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/at
::#
:dk_arrayAt
	call dk_debugFunc
	if %__ARGC__% lss 2 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	if %__ARGC__% gtr 3 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	::call dk_validateArgs array int optional:rtn_var
	setlocal

	::### return value ###
	if "!!" neq "" endlocal & call dk_set %3 "%%%~1[%~2]%%"
	if "!!" equ "" endlocal & set "%3=!%~1[%~2]!"
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	set "myArrayA[0]=a b c"
	set "myArrayA[1]=1 2 3"
	set "myArrayA[2]=d e f"
	set "myArrayA[3]=4 5 6"
	set "myArrayA[4]=h i j"
	call dk_printVar myArrayA
	call dk_arrayAt MyArrayA 2 arrayAtA
	call dk_printVar arrayAtA
	if "%arrayAtA%" neq "d e f" call dk_error "dk_arrayAt() failed"
	if "%arrayAtA%" equ "d e f" call dk_info "dk_arrayAt() suceeded" 
	
	set "myArrayB[0]=h i j"
	set "myArrayB[1]=4 5 6"
	set "myArrayB[2]=d e f"
	set "myArrayB[3]=1 2 3"
	set "myArrayB[4]=a b c"
	call dk_printVar myArrayB
	call dk_arrayAt MyArrayB 3 arrayAtB
	call dk_printVar arrayAtB
	if "%arrayAtB%" neq "1 2 3" call dk_error "dk_arrayAt() failed"
	if "%arrayAtB%" equ "1 2 3" call dk_info "dk_arrayAt() suceeded" 
goto:eof
