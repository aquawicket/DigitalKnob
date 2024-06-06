@echo off
call DK

::################################################################################
::# dk_arrayPop(<array>)
::#
::#    reference: https://www.w3schools.com/js/js_array_methods.asp#mark_pop
::#
:dk_arrayPop () {
	call dk_debugFunc
	if %__ARGC__% neq 1 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	call dk_arrayLength %~1 last_element
	set /a last_element-=1
	call dk_unset %~1[%last_element%]
goto:eof




:DKTEST ########################################################################

	echo testing dk_arrayShift . . .
	set "MyArray[0]=a"
	set "MyArray[1]=b"
	set "MyArray[2]=c"
	set "MyArray[3]=d"
	set "MyArray[4]=e"
	
	call dk_printArray MyArray
	
	call dk_arrayPop MyArray
	call dk_printArray MyArray
	
	call dk_arrayPop MyArray
	call dk_printArray MyArray
	
	call dk_arrayPop MyArray
	call dk_printArray MyArray
	
	call dk_arrayPop MyArray
	call dk_printArray MyArray
	
	call dk_arrayPop MyArray
	call dk_printArray MyArray
	
	call dk_arrayPop MyArray
	call dk_printArray MyArray
	
	call dk_arrayPop MyArray
	call dk_printArray MyArray
	
	call dk_arrayPop MyArray
	call dk_printArray MyArray