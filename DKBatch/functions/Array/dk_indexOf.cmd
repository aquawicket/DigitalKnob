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
rem # Array/dk_indexOf(array, searchElement)
rem # Array/dk_indexOf(array, searchElement, rtn_val)
rem # Array/dk_indexOf(array, searchElement, fromIndex)
rem # Array/dk_indexOf(array, searchElement, fromIndex, rtn_val)
rem #
rem #	The indexOf() method of Array instances returns the first index at which a given element can be found in the array, or -1 if it is NOT present.
rem #
rem #	PARAMETERS
rem #	searchElement
rem #		Element to locate in the array
rem #
rem #	fromIndex :optional
rem #		Zero-based index at which to start searching, converted to an integer.
rem #			Negative index counts back from the end of the array — if -Array/length <= fromIndex < 0, fromIndex + Array/length is used.
rem #			Note, the array is still searched from front to back in this case.
rem #			If fromIndex < -Array/length or fromIndex is omitted, 0 is used, causing the entire array to be searched.
rem #			If fromIndex >= Array/length, the array is NOT searched and -1 is returned.
rem #
rem #	RETURN VALUE
rem #	The first index of searchElement in the array; -1 if NOT found.
rem #
rem #	REFERENCE
rem #	https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/indexOf
rem #
:dk_indexOf
%setlocal%
	
	set /a "_count_=0"
	:indexOf_loop
		if NOT defined %~1[%_count_%] (
			endlocal & %dk_call% dk_set dk_indexOf -1
			%endfunction%
		)

		if "!!" equ "" (set "_value_=!%~1[%_count_%]!")
		if "!!" neq "" (call set "_value_=%%%~1[%_count_%]%%")
		if "%~2" equ "%_value_%" (
			endlocal & set "dk_indexOf=%_count_%"
			%endfunction%
		)
		rem ###### case-insensitive compair ######
		rem if /i "%~2" equ "%_value_%" (
		rem	endlocal & set "dk_indexOf=%_count_%"
		rem	%endfunction%
		rem )

		set /a "_count_+=1"
	goto indexOf_loop
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

	%dk_call% Array/dk_indexOf myArrayA "a b c"
	%dk_call% dk_echo "index of 'a b c' = %dk_indexOf%"

	%dk_call% Array/dk_indexOf myArrayA "1 2 3"
	%dk_call% dk_echo "index of '1 2 3' = %dk_indexOf%"

	%dk_call% Array/dk_indexOf myArrayA "d e f"
	%dk_call% dk_echo "index of 'd e f' = %dk_indexOf%"

	%dk_call% Array/dk_indexOf myArrayA "4 5 6"
	%dk_call% dk_echo "index of '4 5 6' = %dk_indexOf%"

	%dk_call% Array/dk_indexOf myArrayA "h i j"
	%dk_call% dk_echo "index of 'h i j' = %dk_indexOf%"

	%dk_call% Array/dk_indexOf myArray "nonExistant"
	%dk_call% dk_echo "index of 'nonExistant' = %dk_indexOf%"
%endfunction%
