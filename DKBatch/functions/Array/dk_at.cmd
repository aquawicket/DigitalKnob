@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# Array/dk_at(array, index)
::#
::#	Takes an array instance with an integer value and returns the item at that index,
::#	allowing for positive and negative integers. Negative integers count back from the last item in the array  <-- TODO
::#
::#	PARAMETERS
::#	index
::#	Zero-based index of the array element to be returned, converted to an integer. Negative index counts back from the end of the array — if index < 0, index + Array/length is accessed.
::#
::#	RETURN VALUE
::#	The element in the array matching the given index. Always returns undefined if index < -Array/length or index >= Array/length without attempting to access the corresponding property.
::#
::#	https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/at
::#
:dk_at
%setlocal%
	%dk_call% dk_debugFunc 2

::###### faster #####################
	endlocal & set "dk_at=!%~1[%~2]!"
	%return%
::###################################
	
	::###### input #######
	set "_array_=%~1"
	set "_index_-%~2"
	
	
	set "dk_at=!%_array_%[%_index_%]!"
	
	
	::###### output ######
	endlocal & (
		set "dk_at=%dk_at%"
		if "%~2" neq "" (set "%~2=%dk_at%")
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
	%dk_call% dk_printVar myArrayA
	%dk_call% Array/dk_at MyArrayA 2
	%dk_call% dk_echo "Array/dk_at[MyArrayA 2] = %dk_at%"
	if "%dk_at%" neq "d e f" (%dk_call% dk_error "Array/dk_at[] failed")
	if "%dk_at%" equ "d e f" (%dk_call% dk_success "Array/dk_at[] suceeded")

	set "myArrayB[0]=h i j"
	set "myArrayB[1]=4 5 6"
	set "myArrayB[2]=d e f"
	set "myArrayB[3]=1 2 3"
	set "myArrayB[4]=a b c"
	%dk_call% dk_printVar myArrayB
	%dk_call% Array/dk_at MyArrayB 3
	%dk_call% dk_echo "Array/dk_at[MyArrayB 3] = %dk_at%"
	if "%dk_at%" neq "1 2 3" (%dk_call% dk_error "Array/dk_at[] failed")
	if "%dk_at%" equ "1 2 3" (%dk_call% dk_success "Array/dk_at[] suceeded")
%endfunction%
