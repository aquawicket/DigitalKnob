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
rem # String/split(string, separator)
rem # String/split(string, separator, array:optional)
rem #
rem #	The split() method of String values takes a pattern and divides this string into an ordered list of substrings by searching for the pattern,
rem # puts these substrings into an array, and returns the array.
rem #
rem #	PARAMETERS
rem #  separator
rem # 	The pattern describing where each split should occur. Can be undefined, a string, or an object with a Symbol.split method — the typical example being a regular expression.
rem # 	Omitting separator or passing undefined causes split() to return an array with the calling string as a single element. All values that are NOT undefined or objects with a
rem # 	[Symbol.split]() method are coerced to strings.
rem #  
rem #  limit Optional
rem #		A non-negative integer specifying a limit on the number of substrings to be included in the array. If provided, splits the string at each occurrence of the specified
rem #		separator, but stops when limit entries have been placed in the array. Any leftover text is NOT included in the array at all.
rem #
rem #  Return value
rem # 	If separator is a string, an Array of strings is returned, split at each point where the separator occurs in the given string.
rem #		If separator is a regex, the returned Array also contains the captured groups for each separator match; see below for details. The capturing groups may be unmatched,
rem #		in which case they are undefined in the array.
rem #
rem #  REFERENCE
rem #		https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/split
rem #
:dk_split
%setlocal%
	
	set "str=%~1"
	set /a "n=0"
	:loop
	for /F "tokens=1* delims=;" %%a in ("%str%") do (
		rem echo dk_split[!n!] = %%a
		set "dk_split[!n!]=%%a"
		set "str=%%b"
		set /a "n+=1"
	)
	if defined str goto :loop
	
	rem Return the array to the calling scope
	set "_SCOPE_=%~n0"
	for /F "delims=" %%a in ('set dk_split[') do (
		if "%_SCOPE_%" equ "%~n0" endlocal
		set "%%a"
	)
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% String/dk_split "abc;123;def;456;ghi;789;jkl"
	%dk_call% dk_printVar dk_split
%endfunction%
