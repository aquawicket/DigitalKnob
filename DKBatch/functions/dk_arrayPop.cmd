@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_arrayPop(array)
::# dk_arrayPop(array, rtn_var)
::#
::#    The pop() method of Array instances removes the last element from an array and returns that element. This method changes the length of the array.
::#
::#    PARAMETERS
::#    array
::#
::#	   RETURN VALUE
::#    The removed element from the array; undefined if the array is empty.
::#
::#    REFERENCE
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/pop
::#
:dk_arrayPop
	call dk_debugFunc
	call dk_minMaxArgs 1 2
	::if %__ARGC__% lss 1 call dk_error "%__FUNCTION__%:%__ARGV__% not enough arguments"
	::if %__ARGC__% gtr 2 call dk_error "%__FUNCTION__%:%__ARGV__% too many arguments"
	::dk_validateArgs array
	
	setlocal
	call dk_arrayLength %~1 _length_
	set /a _length_-=1
	set "removedElement=!%~1[%_length_%]!"
	call dk_printVar removedElement
	endlocal & set "%~2=%removedElement%" & call dk_unset %~1[%_length_%]
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	call dk_minMaxArgs 0
	
	set "myArrayA[0]=a b c"
	set "myArrayA[1]=1 2 3"
	set "myArrayA[2]=d e f"
	set "myArrayA[3]=4 5 6"
	set "myArrayA[4]=h i j"
	
	call dk_printVar myArrayA 
	call dk_echo
	
	call dk_arrayPop myArrayA removedA
	call dk_printVar myArrayA
	call dk_printVar removedA
	call dk_echo
	
	call dk_arrayPop myArrayA removedA
	call dk_printVar myArrayA
	call dk_printVar removedA
	call dk_echo
	
	call dk_arrayPop myArrayA removedA
	call dk_printVar myArrayA
	call dk_printVar removedA
	call dk_echo
	
	call dk_arrayPop myArrayA removedA
	call dk_printVar myArrayA
	call dk_printVar removedA
	call dk_echo
	
	call dk_arrayPop myArrayA removedA
	call dk_printVar myArrayA
	call dk_printVar removedA
	call dk_echo
	
::  FIXME:  out of array bounds past here
::	call dk_arrayPop myArrayA removedA
::	call dk_printVar myArrayA
::	call dk_printVar removedA
	call dk_echo
	call dk_echo
goto:eof
