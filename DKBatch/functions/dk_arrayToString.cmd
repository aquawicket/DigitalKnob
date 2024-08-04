@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_arrayToString(array rtn_var)
::#
::#   https://www.w3schools.com/js/js_array_methods.asp#mark_tostring
::#   https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/toString
::#
:dk_arrayToString
	call dk_debugFunc
	call dk_minMaxArgs 2
	if %__ARGC__% neq 2 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"

	setlocal
	call dk_arrayJoin %~1 "," arrayStr
	endlocal & set "%2=%arrayStr%"
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
	call dk_arrayToString MyArrayA MyStringA
	call dk_info "MyStringA = %MyStringA%"
goto:eof
