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
rem # Array::dk_concat(array, {value1, value2, /* …, */ valueN})
rem #
rem #  Merge two or more arrays. This method does NOT change the existing arrays, but instead returns a new array
rem #
rem #	PARAMETERS
rem #	value1, …, valueN Optional
rem #		Arrays and/or values to concatenate into a new array
rem #		If all valueN parameters are omitted, concat returns a shallow copy of the existing array on which it is called. See the description below for more details.
rem #
rem #	RETURN VALUE
rem #	A new Array instance.
rem #
rem #	REFERENCE
rem #	https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/concat
rem #
:dk_concat
%setlocal%

	set "_arrayA_=%~1"
	set "_arrayB_=%~2"
	set "dk_concat=dk_concat"

	set /a "countA=0"
	set /a "countB=0"
	:concat_loop1
	if defined %_arrayA_%[%countA%] (
		set "%dk_concat%[%countB%]=!%_arrayA_%[%countA%]!"
		set /a "countA+=1"
		set /a "countB+=1"
		goto concat_loop1
	)
	set /a countA=0
	:concat_loop2
	if defined %_arrayB_%[%countA%] (
		set "%dk_concat%[%countB%]=!%_arrayB_%[%countA%]!"
		set /a "countA+=1"
		set /a "countB+=1"
		goto :concat_loop2
	)

	rem Return the array to the calling scope
	set "_SCOPE_=%~n0"
	for /F "delims=" %%a in ('set %dk_concat%[') do (
		if "%_SCOPE_%" equ "%~n0" endlocal
		set "%%a"
	)
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_echo
	set "myArray1[0]=a b c"
	set "myArray1[1]=d e f"
	set "myArray1[2]=g h i"
	%dk_call% dk_printVar myArray1

	%dk_call% dk_echo
	set "myArray2[0]=1 2 3"
	set "myArray2[1]=4 5 6"
	set "myArray2[2]=7 8 9"
	%dk_call% dk_printVar myArray2

	%dk_call% dk_echo
	%dk_call% Array::dk_concat myArray1 myArray2
	%dk_call% dk_printVar dk_concat

	%dk_call% dk_echo
	if ^
	"%dk_concat[0]%" equ "a b c" if ^
	"%dk_concat[1]%" equ "d e f" if ^
	"%dk_concat[2]%" equ "g h i" if ^
	"%dk_concat[3]%" equ "1 2 3" if ^
	"%dk_concat[4]%" equ "4 5 6" if ^
	"%dk_concat[5]%" equ "7 8 9" (
		%dk_call% dk_success "Array::dk_concat succeeded"
		%return%
	)
	
	%dk_call% dk_error "Array::dk_concat failed"
%endfunction%
