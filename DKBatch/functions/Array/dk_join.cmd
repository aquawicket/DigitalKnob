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
rem # Array/dk_join(array, separator)
rem #
rem #	The join() method of Array instances creates and returns a new string by concatenating all of the elements in this array, separated by commas or a specified separator string.
rem #	If the array has only one item, then that item will be returned without using the separator.
rem #
rem #	PARAMETERS
rem #	separator :optional
rem #		A string to separate each pair of adjacent elements of the array. If omitted, the array elements are separated with a comma (",").
rem #
rem #	RETURN VALUE
rem #	A string with all array elements joined. If Array/length is 0, the empty string is returned.
rem #
rem #	REFERENCE
rem #	https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/join
rem #
:dk_join
%setlocal%

	rem set "_arry_=%~1"
	rem set "_separator_=%~2"
	set "_count_=0"
	:join_loop
	if defined %~1[%_count_%] (
		if defined _string_ (
			set "_string_=%_string_%%~2!%~1[%_count_%]!"
		) else (
			set "_string_=!%~1[%_count_%]!"
		)
		set /a "_count_+=1"
		goto join_loop
	)
	endlocal & set "dk_join=%_string_%"
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
	
	%dk_call% Array/dk_join myArrayA ";"
	%dk_call% dk_info "dk_join = '%dk_join%'"


	set "myArrayB[0]=h i j"
	set "myArrayB[1]=4 5 6"
	set "myArrayB[2]=d e f"
	set "myArrayB[3]=1 2 3"
	set "myArrayB[4]=a b c"
	%dk_call% dk_printVar myArrayB
	
	%dk_call% Array/dk_join myArrayB ";"
	%dk_call% dk_info "dk_join = '%dk_join%'"
%endfunction%
