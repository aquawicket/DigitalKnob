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
rem # Array/dk_push(array, element1, element2, /* …, */ elementN)
rem #
rem #	The push() method of Array instances adds the specified elements to the end of an array and returns the new length of the array
rem #
rem #	PARAMETERS
rem #	element1, …, elementN
rem #		The element(s) to add to the end of the array
rem #
rem #	RETURN VALUE
rem #	The new length property of the object upon which the method was called.
rem #
rem #	REFERENCE
rem #	https://www.w3schools.com/js/js_array_methods.asp#mark_push
rem #	https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/push
rem #
:dk_push
%setlocal%
	%dk_call% Array/dk_length %~1
	set /a "dk_push=dk_length+1"
	
	For /F "tokens=1*" %%A in ("%*") DO (
		set ARGN=%%B
		set -ARGN=%%~B
	)

	:return
	endlocal & (
		set %~1[%dk_length%]=%-ARGN%
		set "dk_push=%dk_push%"
	)
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_echo
	%dk_call% Array/dk_push myArrayA "a b c"
	%dk_call% dk_printVar myArrayA
	%dk_call% dk_printVar dk_push

	%dk_call% dk_echo
	%dk_call% Array/dk_push myArrayA 1 2 3 d e f
	%dk_call% dk_printVar myArrayA
	%dk_call% dk_printVar dk_push
	
	%dk_call% dk_echo
	%dk_call% Array/dk_push myArrayA "4 5 6" "h i j"
	%dk_call% dk_printVar myArrayA
	%dk_call% dk_printVar dk_push

%endfunction%
