@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_arrayShift(array)
::# dk_arrayShift(array, rtn_var)
::#
::#	 Removes the first element from an array and returns that removed element. 
::#    This method changes the length of the array.
::#
::#    PARAMETERS
::#    array
::#
::#    RETURN VALUE
::#    The removed element from the array; undefined if the array is empty.
::#    
::#    REFERENCE
::#    https://www.w3schools.com/js/js_array_methods.asp#mark_shift
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/shift
::#
:dk_arrayShift
	call dk_debugFunc
	if %__ARGC__% lss 1 call dk_error "%__FUNCTION__%:%__ARGV__% not enough arguments"
	if %__ARGC__% gtr 2 call dk_error "%__FUNCTION__%:%__ARGV__% too many arguments"
	::dk_validateArgs array
	
	setlocal
	set "_arry_=%~1"
	set prev=0
	set count=1
	:dk_arrayShift_loop
	if defined %_arry_%[%count%] (
		call set "%_arry_%[%prev%]=%%%_arry_%[%count%]%%"  &:: FIXME: remove the need for call here
		set /a count+=1
		set /a prev+=1
		goto:dk_arrayShift_loop
	)
	endlocal & call dk_unset %_arry_%[%prev%]
	::endlocal & set "%_arry_%[%prev%]="
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
	call dk_echo
	
	call dk_arrayShift myArrayA removedA
	call dk_printVar myArrayA
	call dk_printVar removedA
	call dk_echo
	
	call dk_arrayShift myArrayA removedA
	call dk_printVar myArrayA
	call dk_printVar removedA
	call dk_echo
	
	call dk_arrayShift myArrayA removedA
	call dk_printVar myArrayA
	call dk_printVar removedA
	call dk_echo
	
	call dk_arrayShift myArrayA removedA
	call dk_printVar myArrayA
	call dk_printVar removedA
	call dk_echo
	
	call dk_arrayShift myArrayA removedA
	call dk_printVar myArrayA
	call dk_printVar removedA
	call dk_echo
	
	:: FIXME:  out of array bounds past here
::	call dk_arrayShift myArrayA removedA
::	call dk_printVar myArrayA
::	call dk_printVar removedA
	call dk_echo
	call dk_echo
goto:eof
