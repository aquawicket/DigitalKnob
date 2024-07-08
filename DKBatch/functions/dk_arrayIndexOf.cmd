@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::################################################################################
::# dk_arrayIndexOf(array, searchElement, rtn_var)
::# dk_arrayIndexOf(array, searchElement, fromIndex, rtn_var)
::#
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/indexOf
::#
:dk_arrayIndexOf
	call dk_debugFunc
	if %__ARGC__% neq 3 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	set _count_=0
	:dk_arrayIndexOf_loop
		if not defined %~1[%_count_%] (
			endlocal & call dk_set %3 -1
			goto:eof
		)
		
		call set "_value_=%%%~1[%_count_%]%%"
		if "%~2" == "%_value_%" (
			endlocal & call dk_set %3 "%_count_%"
			goto:eof
				
		)
			
		set /a _count_+=1
	goto:dk_arrayIndexOf_loop
goto:eof




:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	call dk_debugFunc
	
	set "myArray[0]=a"
	set "myArray[1]=b"
	set "myArray[2]=c"
	set "myArray[3]=d"
	set "myArray[4]=e"
	
	call dk_arrayIndexOf myArray "a" indexA
	echo indexA = %indexA%
	
	call dk_arrayIndexOf myArray "b" indexB
	echo indexB = %indexB%
	
	call dk_arrayIndexOf myArray "c" indexC
	echo indexC = %indexC%
	
	call dk_arrayIndexOf myArray "d" indexD
	echo indexD = %indexD%
	
	call dk_arrayIndexOf myArray "e" indexE
	echo indexE = %indexE%
	
	call dk_arrayIndexOf myArray "nonExistant" indexN
	echo indexN = %indexN%
goto:eof
