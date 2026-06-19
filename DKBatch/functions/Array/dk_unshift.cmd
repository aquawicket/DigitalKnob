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
rem # Array::dk_unshift(array, element)
rem #
rem #	Adds the specified elements to the beginning of an array and returns the new length of the array
rem #
rem #	PARAMETERS
rem #	element1, …, elementN
rem #	The elements to add to the front of the arr.
rem #
rem #	RETURN VALUE
rem #	The new length property of the object upon which the method was called.
rem #
rem #	https://www.w3schools.com/js/js_array_methods.asp#mark_unshift
rem #	https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/unshift
rem #
:dk_unshift
rem %setlocal%

	set "_arry_=%~1"
	%dk_call% Array/dk_length %~1
	set /a "dk_unshift=dk_length+1"

	set /a "prev=dk_length-1"

	:unshift_loop
	if %dk_length% gtr 0 (
		set "%_arry_%[%dk_length%]=!%_arry_%[%prev%]!"
		set /a dk_length-=1
		set /a prev-=1
		goto unshift_loop
	)
	endlocal & set "%~1[0]=%~2" & set "dk_unshift=%dk_unshift%"
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_echo
	%dk_call% Array::dk_unshift myArrayA "a b c"
	%dk_call% dk_printVar myArrayA
	%dk_call% dk_printVar dk_unshift

	%dk_call% dk_echo
	%dk_call% Array::dk_unshift myArrayA "1 2 3"
	%dk_call% dk_printVar myArrayA
	%dk_call% dk_printVar dk_unshift

	%dk_call% dk_echo
	%dk_call% Array::dk_unshift myArrayA "d e f"
	%dk_call% dk_printVar myArrayA
	%dk_call% dk_printVar dk_unshift

	%dk_call% dk_echo
	%dk_call% Array::dk_unshift myArrayA "4 5 6"
	%dk_call% dk_printVar myArrayA
	%dk_call% dk_printVar dk_unshift

	%dk_call% dk_echo
	%dk_call% Array::dk_unshift myArrayA "h i j"
	%dk_call% dk_printVar myArrayA
	%dk_call% dk_printVar dk_unshift
%endfunction%
