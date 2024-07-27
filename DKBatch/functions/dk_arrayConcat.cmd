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
	if %__ARGC__% lss 2 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	if %__ARGC__% gtr 3 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	::#dk_validateArgs array array
	
	set "_arry1_=%~1"
	set "_arry2_=%~2"
	set "_arry3_=%~3"
	set /a countA=0
	set /a countB=0
	:dk_arrayConcat_loop1
	if defined %_arry1_%[%countA%] (
		call set "%_arry3_%[%countB%]=%%%_arry1_%[%countA%]%%"  &:: FIXME: remove the need for call here
		set /a countA+=1
		set /a countB+=1
		goto:dk_arrayConcat_loop1
	)
	set /a countA=0
	:dk_arrayConcat_loop2
	if defined %_arry2_%[%countA%] (
		call set "%_arry3_%[%countB%]=%%%_arry2_%[%countA%]%%"  &:: FIXME: remove the need for call here
		set /a countA+=1
		set /a countB+=1
		goto:dk_arrayConcat_loop2
	)

	
	::### return value ###
	if "!!" neq "" endlocal & call dk_set %3 "%_arry3_%"
	if "!!" equ "" endlocal & set "%3=!_arry3_!"
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc

	set "myArray1[0]=a b c"
	set "myArray1[1]=d e f"
	set "myArray1[2]=g h i"
	
	set "myArray2[0]=1 2 3"
	set "myArray2[1]=4 5 6"
	set "myArray2[2]=7 8 9"
	
	call dk_arrayConcat myArray1 myArray2 myNewArrayA
	call dk_printVar myNewArrayA
	
	if ^
	"%myNewArrayA[0]%" == "a b c" if ^
	"%myNewArrayA[1]%" == "d e f" if ^
	"%myNewArrayA[2]%" == "g h i" if ^
	"%myNewArrayA[3]%" == "1 2 3" if ^
	"%myNewArrayA[4]%" == "4 5 6" if ^
	"%myNewArrayA[5]%" == "7 8 9" dk_echo "dk_arrayConcat succeeded"
goto:eof
