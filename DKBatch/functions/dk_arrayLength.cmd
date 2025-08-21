@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_arrayLength(array)
::#
::#	The length data property of an Array instance represents the number of elements in that array
::#	The value is an unsigned, 32-bit integer that is always numerically greater than the highest index in the array
::#
::#	REFERENCE
::#	https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/length
::#
:dk_arrayLength
%setlocal%
	%dk_call% dk_debugFunc 1

	if NOT defined %~1[0] (
		%dk_call% dk_error "dk_arrayLength(%*): arg1 must be the name of an array variable without surrounding percent signs or exclamation marks"
	)
	
	
	set dk_arrayLength=0
	:dk_arrayLength.loop
	if defined %~1[%dk_arrayLength%] (
		set /a dk_arrayLength+=1
		goto :dk_arrayLength.loop
	)
	
	
	::###### output ######
	endlocal & (
		set "dk_arrayLength=%dk_arrayLength%"
		if "%~2" neq "" (set "%~2=%dk_arrayLength%") else (echo %dk_arrayLength%)
	)
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	set "myArrayA[0]=a b c"
	set "myArrayA[1]=1 2 3"
	set "myArrayA[2]=d e f"
	set "myArrayA[3]=4 5 6"
	set "myArrayA[4]=h i j"

	%dk_call% dk_arrayLength myArrayA
	%dk_call% dk_debug "dk_arrayLength = %dk_arrayLength%"
%endfunction%
