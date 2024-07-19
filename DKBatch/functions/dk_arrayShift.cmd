@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::################################################################################
::# dk_arrayShift(array)
::#
::#    https://www.w3schools.com/js/js_array_methods.asp#mark_shift
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/shift
::#
:dk_arrayShift
	call dk_debugFunc
	if %__ARGC__% neq 1 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
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
	call dk_unset %_arry_%[%prev%]
goto:eof







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	set "MyArray[0]=a"
	set "MyArray[1]=b"
	set "MyArray[2]=c"
	set "MyArray[3]=d"
	set "MyArray[4]=e"
	
	call dk_printVar MyArray
	
	call dk_arrayShift MyArray
	call dk_printVar MyArray
	
	call dk_arrayShift MyArray
	call dk_printVar MyArray
	
	call dk_arrayShift MyArray
	call dk_printVar MyArray
	
	call dk_arrayShift MyArray
	call dk_printVar MyArray
	
	call dk_arrayShift MyArray
	call dk_printVar MyArray
	
	call dk_arrayShift MyArray
	call dk_printVar MyArray
goto:eof
