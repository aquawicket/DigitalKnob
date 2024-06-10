@echo off
call DK

::################################################################################
::# dk_arrayIndexOf(array, searchElement, index)
::# dk_arrayIndexOf(array, searchElement, fromIndex, index)
::#
::#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/indexOf
::#
:dk_arrayIndexOf () {
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

	set "array[0]=a"
	set "array[1]=b"
	set "array[2]=c"
	set "array[3]=d"
	set "array[4]=e"
	
	call dk_arrayIndexOf array "a" indexA
	echo indexA = %indexA%
	
	call dk_arrayIndexOf array "b" indexB
	echo indexB = %indexB%
	
	call dk_arrayIndexOf array "c" indexC
	echo indexC = %indexC%
	
	call dk_arrayIndexOf array "d" indexD
	echo indexD = %indexD%
	
	call dk_arrayIndexOf array "e" indexE
	echo indexE = %indexE%
	
	call dk_arrayIndexOf array "nonExistant" indexN
	echo indexN = %indexN%
	