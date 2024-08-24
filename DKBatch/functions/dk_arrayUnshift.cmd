@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_arrayUnshift(array, element)
::# dk_arrayUnshift(array, element, rtn_var)
::#
::#    Adds the specified elements to the beginning of an array and returns the new length of the array.
::#
::#    PARAMETERS
::#    element1, …, elementN
::#    The elements to add to the front of the arr.
::#
::#    RETURN VALUE
::#    The new length property of the object upon which the method was called.
::#
::#    https://www.w3schools.com/js/js_array_methods.asp#mark_unshift
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/unshift
::#
:dk_arrayUnshift
 ::setlocal
	::call dk_debugFunc 2
	
	set "_arry_=%~1"
	::set "_element_=%~2"
	%dk_call% dk_arrayLength %~1 count
	set /a "prev=count-1"
	
	:dk_arrayUnshift_loop
	if %count% gtr 0 (
		rem if "!DE!" neq "" call set "%_arry_%[%count%]=%%%_arry_%[%prev%]%%" &:: FIXME: remove the need for call here
		if "!DE!" equ "" set "%_arry_%[%count%]=!%_arry_%[%prev%]!"
		set /a count-=1
		set /a prev-=1
		goto:dk_arrayUnshift_loop
	)
	endlocal & set "%~1[0]=%~2"
 ::endlocal
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_echo
	%dk_call% dk_arrayUnshift myArrayA "a b c" ::new_lengthA
	%dk_call% dk_printVar myArrayA
	::%dk_call% dk_printVar new_lengthA
	
	%dk_call% dk_echo
	%dk_call% dk_arrayUnshift myArrayA "1 2 3" ::new_lengthA
	%dk_call% dk_printVar myArrayA
	::%dk_call% dk_printVar new_lengthA
	
	%dk_call% dk_echo
	%dk_call% dk_arrayUnshift myArrayA "d e f" ::new_lengthA
	%dk_call% dk_printVar myArrayA
	::%dk_call% dk_printVar new_lengthA
	
	%dk_call% dk_echo
	%dk_call% dk_arrayUnshift myArrayA "4 5 6" ::new_lengthA
	%dk_call% dk_printVar myArrayA
	::%dk_call% dk_printVar new_lengthA
	
	%dk_call% dk_echo
	%dk_call% dk_arrayUnshift myArrayA "h i j" ::new_lengthA
	%dk_call% dk_printVar myArrayA
	::%dk_call% dk_printVar new_lengthA
	
 endlocal
goto:eof
