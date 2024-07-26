@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_arrayPush(array, element1, element2, /* …, */ elementN)
::#
::#    The push() method of Array instances adds the specified elements to the end of an array and returns the new length of the array.
::#
::#    PARAMETERS
::#    element1, …, elementN
::#        The element(s) to add to the end of the array.
::#
::#    RETURN VALUE
::#    The new length property of the object upon which the method was called.
::#
::#    REFERENCE
::#    https://www.w3schools.com/js/js_array_methods.asp#mark_push
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/push
::#
:dk_arrayPush
	call dk_debugFunc
	if %__ARGC__% lss 2 call dk_error "%__FUNCTION__%:%__ARGV__% not enough arguments"
	if %__ARGC__% gtr 3 call dk_error "%__FUNCTION__%:%__ARGV__% too many arguments"
	
	setlocal
	call dk_arrayLength %~1 end_index
	endlocal & set "%~1[%end_index%]=%~2"
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_arrayPush myArrayA "a b c"          &:: new_lengthA
	call dk_printVar myArrayA
	:: dk_printVar new_lengthA
	call dk_echo
	
	call dk_arrayPush myArrayA "1 2 3" "d e f"  &:: new_lengthA
	call dk_printVar myArrayA
	:: dk_printVar new_lengthA
	call dk_echo
	
	call dk_arrayPush myArrayA "4 5 6" "h i j"  &:: new_lengthA
	call dk_printVar myArrayA
	:: dk_printVar new_lengthA
	call dk_echo
goto:eof
