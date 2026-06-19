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


rem #################################################################################
rem # Array::dk_at(array, index)
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
:dk_at
%setlocal%

	endlocal & (
		rem set "Array::dk_at_*=%*"
		rem set "Array::dk_at_1=%~1"
		rem set "Array::dk_at_2=%~2"
		rem set "Array::dk_at_3=%~3"
		set "Array_dk_at=!%~1[%~2]!"
	)
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	rem set "foo=FOO"
	rem set "bar=BAR"
	set "foo:bar=FOO_BAR"
	set foo:bar
	echo foo:bar = '%foo:bar%'
	echo foo:bar = '!foo:bar!'
	SETLOCAL DisableExtensions
	echo foo:bar = '%foo:bar%'
	echo foo:bar = '!foo:bar!'
	endlocal
	
	set "myArrayA[0]=a b c"
	set "myArrayA[1]=1 2 3"
	set "myArrayA[2]=d e f"
	set "myArrayA[3]=4 5 6"
	set "myArrayA[4]=h i j"
	%dk_call% dk_printVar myArrayA
	%dk_call% Array::dk_at MyArrayA 2
	%dk_call% dk_echo "Array_dk_at = %Array_dk_at%"
	if "%Array_dk_at%" neq "d e f" (%dk_call% dk_error "Array::dk_at failed")
	if "%Array_dk_at%" equ "d e f" (%dk_call% dk_success "Array::dk_at suceeded")

	set "myArrayB[0]=h i j"
	set "myArrayB[1]=4 5 6"
	set "myArrayB[2]=d e f"
	set "myArrayB[3]=1 2 3"
	set "myArrayB[4]=a b c"
	%dk_call% dk_printVar myArrayB
	%dk_call% Array::dk_at MyArrayB 3
	%dk_call% dk_echo "Array_dk_at = %Array_dk_at%"
	if "%Array_dk_at%" neq "1 2 3" (%dk_call% dk_error "Array::dk_at failed")
	if "%Array_dk_at%" equ "1 2 3" (%dk_call% dk_success "Array::dk_at suceeded")
%endfunction%
