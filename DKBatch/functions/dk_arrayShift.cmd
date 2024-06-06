@echo off
call DK

::################################################################################
::# dk_arrayShift(<array>)
::#
::#    reference: https://www.w3schools.com/js/js_array_methods.asp#mark_shift
::#
:dk_arrayShift () {
	call dk_debugFunc
	if %__ARGC__% neq 1 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	set "_arry_=%~1"
	set prev=0
	set count=1
	:dk_arrayShift_loop
	if defined %_arry_%[%count%] (
		rem echo count = %count%
		rem echo prev = %prev%
		call set "%_arry_%[%prev%]=%%%_arry_%[%count%]%%"
		set /a count+=1
		set /a prev+=1
		goto:dk_arrayShift_loop
	)
	call dk_unset %_arry_%[%prev%]
goto:eof




:DKTEST ########################################################################

	echo testing dk_arrayShift . . .
	set "MyArray[0]=a"
	set "MyArray[1]=b"
	set "MyArray[2]=c"
	set "MyArray[3]=d"
	set "MyArray[4]=e"
	
	call dk_printArray MyArray
	
	call dk_arrayShift MyArray
	call dk_printArray MyArray
	
	call dk_arrayShift MyArray
	call dk_printArray MyArray
	
	call dk_arrayShift MyArray
	call dk_printArray MyArray
	
	call dk_arrayShift MyArray
	call dk_printArray MyArray
	
	call dk_arrayShift MyArray
	call dk_printArray MyArray
	
	call dk_arrayShift MyArray
	call dk_printArray MyArray
	