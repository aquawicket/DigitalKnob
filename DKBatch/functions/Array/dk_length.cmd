@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################################################################################
::# Array/dk_length(array)
::#
::#	The length data property of an Array instance represents the number of elements in that array
::#	The value is an unsigned, 32-bit integer that is always numerically greater than the highest index in the array
::#
::#	REFERENCE
::#	https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/length
::#
:dk_length
setlocal
	%dk_call% dk_debugFunc 1

	set dk_length=0
	:length_loop
	if defined %~1[%dk_length%] ( 
		set /a dk_length+=1
		goto length_loop 
	)
	endlocal & set "dk_length=%dk_length%"
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	set "myArrayA[0]=a b c"
	set "myArrayA[1]=1 2 3"
	set "myArrayA[2]=d e f"
	set "myArrayA[3]=4 5 6"
	set "myArrayA[4]=h i j"

	%dk_call% Array/dk_length myArrayA
	%dk_call% dk_debug "dk_length = %dk_length%"
%endfunction%
