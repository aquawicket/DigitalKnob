@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ################################################################################
rem # dk_arrayAt(array, index)
rem #
rem #	Takes an array instance with an integer value and returns the item at that index,
rem #	allowing for positive and negative integers. Negative integers count back from the last item in the array  <-- TODO
rem #
rem #	PARAMETERS
rem #	index
rem #	Zero-based index of the array element to be returned, converted to an integer. Negative index counts back from the end of the array — if index < 0, index + Array/length is accessed.
rem #
rem #	RETURN VALUE
rem #	The element in the array matching the given index. Always returns undefined if index < -Array/length or index >= Array/length without attempting to access the corresponding property.
rem #
rem #	https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/at
rem #
:dk_arrayAt
%setlocal%

	endlocal & (
		rem set "dk_arrayAt_*=%*"
		rem set "dk_arrayAt_1=%~1"
		rem set "dk_arrayAt_2=%~2"
		rem set "dk_arrayAt_3=%~3"
		set "dk_arrayAt=!%~1[%~2]!"
		if "%~3" neq "" (
			set "%~3=!dk_arrayAt!"
		) 
	)
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	set "myArrayA[0]=a b c"
	set "myArrayA[1]=1 2 3"
	set "myArrayA[2]=d e f"
	set "myArrayA[3]=4 5 6"
	set "myArrayA[4]=h i j"
	%dk_call% dk_printVar myArrayA
	%dk_call% dk_arrayAt MyArrayA 2
	%dk_call% dk_echo "dk_arrayAt 2 = %dk_arrayAt%"
	if "%dk_arrayAt%" equ "d e f" (%dk_call% dk_success "dk_arrayAt[] suceeded") else (%dk_call% dk_error "dk_arrayAt[] failed")

	set "myArrayB[0]=h i j"
	set "myArrayB[1]=4 5 6"
	set "myArrayB[2]=d e f"
	set "myArrayB[3]=1 2 3"
	set "myArrayB[4]=a b c"
	%dk_call% dk_printVar myArrayB
	%dk_call% dk_arrayAt MyArrayB 3 resultB
	%dk_call% dk_echo "dk_arrayAt 3 = %dk_arrayAt%"
	if "%dk_arrayAt%" equ "1 2 3" 	(%dk_call% dk_success "dk_arrayAt[] suceeded") else (%dk_call% dk_error "dk_arrayAt[] failed")
	%dk_call% dk_echo "resultB 3 = %resultB%"
	if "%resultB%" equ "1 2 3" 		(%dk_call% dk_success "dk_arrayAt[] suceeded") else (%dk_call% dk_error "dk_arrayAt[] failed")
%endfunction%
