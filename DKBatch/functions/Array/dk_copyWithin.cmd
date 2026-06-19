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
rem # Array::dk_copyWithin(array, target, start)
rem # Array::dk_copyWithin(array, target, start, end)
rem #
rem #		The copyWithin() method of Array instances shallow copies part of this array to another location in the same array and returns this array without modifying its length.
rem #
rem #	PARAMETERS
rem #	target
rem #		Zero-based index at which to copy the sequence to, converted to an integer. This corresponds to where the element at start will be copied to,
rem #		and all elements between start and end are copied to succeeding indices.
rem #			Negative index counts back from the end of the array — if -Array::length <= target < 0, target + Array::length is used.
rem #			if target < -Array::length, 0 is used.
rem #			if target >= Array::length, nothing is copied.
rem #			if target is positioned after start after normalization, copying only happens until the end of Array::length (in other words, copyWithin() never extends the array).
rem #	start
rem #		Zero-based index at which to start copying elements from, converted to an integer.
rem #			Negative index counts back from the end of the array — if -Array::length <= start < 0, start + Array::length is used.
rem #			if start < -Array::length, 0 is used.
rem #			if start >= Array::length, nothing is copied.
rem #	end :optional
rem #		Zero-based index at which to end copying elements from, converted to an integer. copyWithin() copies up to but NOT including end.
rem #			Negative index counts back from the end of the array — if -Array::length <= end < 0, end + Array::length is used.
rem #			if end < -Array::length, 0 is used.
rem #			if end >= Array::length or end is omitted, Array::length is used, causing all elements until the end to be copied.
rem #			if end implies a position before or at the position that start implies, nothing is copied.
rem #
rem #	RETURN VALUE
rem #	The modified array
rem #
rem #	REFERENCE
rem #	https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/copyWithin
rem #
:dk_copyWithin
%setlocal%

	%dk_call% dk_todo "Array::dk_copyWithin"
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% Array::dk_copyWithin array target start end
%endfunction%
