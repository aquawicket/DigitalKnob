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
rem # Array/dk_slice(array, start, end)
rem #
rem #	The slice() method of Array instances returns a shallow copy of a portion of an array into a new array object selected from start to end (end NOT included)
rem #	where start and end represent the index of items in that array. The original array will NOT be modified.
rem #
rem #	PARAMETERS
rem #	start :optional
rem #		Zero-based index at which to start extraction, converted to an integer.
rem #		Negative index counts back from the end of the array — if -Array/length <= start < 0, start + Array/length is used.
rem #		If start < -Array/length or start is omitted, 0 is used.
rem #		If start >= Array/length, an empty array is returned.
rem #  
rem #	end :optional
rem #		Zero-based index at which to end extraction, converted to an integer. slice() extracts up to but NOT including end.
rem #		Negative index counts back from the end of the array — if -Array/length <= end < 0, end + Array/length is used.
rem #		If end < -Array/length, 0 is used.
rem #		If end >= Array/length or end is omitted, Array/length is used, causing all elements until the end to be extracted.
rem #		If end implies a position before or at the position that start implies, an empty array is returned.
rem #
rem #	RETURN VALUE
rem #	A new array containing the extracted elements.
rem #
rem #	REFERENCE
rem #	https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/slice
rem #
:dk_slice
%setlocal%

	%dk_call% dk_todo "Array/dk_slice"
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_slice
%endfunction%
