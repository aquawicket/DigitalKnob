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
rem # Array::dk_shift(array)
rem #
rem #  Removes the first element from an array and returns that removed element.
rem #	This method changes the length of the array
rem #
rem #	PARAMETERS
rem #	array
rem #
rem #	RETURN VALUE
rem #	The removed element from the array; undefined if the array is empty.
rem #	
rem #	REFERENCE
rem #	https://www.w3schools.com/js/js_array_methods.asp#mark_shift
rem #	https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/shift
rem #
:dk_shift
%setlocal%

	set "_arry_=%~1"
	set prev=0
	set count=1
	call set dk_shift=%%%_arry_%[0]%%
	rem set dk_shift=!%_arry_%[0]!

	:shift_loop
	if defined %_arry_%[%count%] (
		call set "%_arry_%[%prev%]=%%%_arry_%[%count%]%%"
		rem set "%_arry_%[%prev%]=!%_arry_%[%count%]!"
		set /a count+=1
		set /a prev+=1
		goto shift_loop
	)
	
	:return
	endlocal & (
		set "dk_shift=%dk_shift%"
		set "%_arry_%[%prev%]="
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
	%dk_call% dk_debug

	%dk_call% Array::dk_shift myArrayA
	%dk_call% dk_printVar myArrayA
	%dk_call% dk_debug "dk_shift = %dk_shift%"
	%dk_call% dk_debug

	%dk_call% Array::dk_shift myArrayA
	%dk_call% dk_printVar myArrayA
	%dk_call% dk_debug "dk_shift = %dk_shift%"
	%dk_call% dk_debug

	%dk_call% Array::dk_shift myArrayA
	%dk_call% dk_printVar myArrayA
	%dk_call% dk_debug "dk_shift = %dk_shift%"
	%dk_call% dk_debug

	%dk_call% Array::dk_shift myArrayA
	%dk_call% dk_printVar myArrayA
	%dk_call% dk_debug "dk_shift = %dk_shift%"
	%dk_call% dk_echo

	%dk_call% Array::dk_shift myArrayA
	%dk_call% dk_printVar myArrayA
	%dk_call% dk_debug "dk_shift = %dk_shift%"
	%dk_call% dk_debug

rem FIXME:  out of array bounds from here on
rem %dk_call% Array::dk_shift myArrayA
rem %dk_call% dk_printVar myArrayA
rem %dk_call% dk_printVar dk_shift
%endfunction%
