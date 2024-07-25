@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_arrayConcat(array, {value1, value2, /* …, */ valueN})
::# dk_arrayConcat(array, {value1, value2, /* …, */ valueN}, rtn_var)
::#
::#	 Merge two or more arrays. This method does not change the existing arrays, but instead returns a new array.
::#
::#    PARAMETERS
::#    value1, …, valueN Optional
::#        Arrays and/or values to concatenate into a new array. 
::#        If all valueN parameters are omitted, concat returns a shallow copy of the existing array on which it is called. See the description below for more details.
::#
::#    RETURN VALUE
::#    A new Array instance.
::#
::#    REFERENCE
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/concat
::#
:dk_arrayConcat
	call dk_debugFunc
	if %__ARGC__% neq 2 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	call dk_todo %__FUNCTION__%
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc

	call dk_arrayConcat array value1
goto:eof
