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
rem # Array/dk_pop(array)
rem #
rem #	The pop() method of Array instances removes the last element from an array and returns that element. This method changes the length of the array
rem #
rem #	PARAMETERS
rem #	array
rem #
rem #	RETURN VALUE
rem #	The removed element from the array; undefined if the array is empty.
rem #
rem #	REFERENCE
rem #	https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/pop
rem #
:dk_pop
%setlocal%
	
	%dk_call% Array/dk_length %~1
	set /a dk_length-=1

	(set dk_pop=!%~1[%dk_length%]!)
	endlocal & (set dk_pop=%dk_pop%) & (set %~1[%dk_length%]=)
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
	%dk_call% dk_echo
	
	%dk_call% Array/dk_pop myArrayA
	%dk_call% dk_printVar myArrayA
	%dk_call% dk_printVar dk_pop
	%dk_call% dk_echo
	
	%dk_call% Array/dk_pop myArrayA
	%dk_call% dk_printVar myArrayA
	%dk_call% dk_printVar dk_pop
	%dk_call% dk_echo
	
	%dk_call% Array/dk_pop myArrayA
	%dk_call% dk_printVar myArrayA
	%dk_call% dk_printVar dk_pop
	%dk_call% dk_echo
	
	%dk_call% Array/dk_pop myArrayA
	%dk_call% dk_printVar myArrayA
	%dk_call% dk_printVar dk_pop
	%dk_call% dk_echo
	
	%dk_call% Array/dk_pop myArrayA
	%dk_call% dk_printVar myArrayA
	%dk_call% dk_printVar dk_pop
	%dk_call% dk_echo
	
rem  FIXME:  out of array bounds from here on
rem  %dk_call% Array/dk_pop myArrayA
rem  %dk_call% dk_printVar myArrayA
rem  %dk_call% dk_printVar dk_pop
	%dk_call% dk_echo
%endfunction%
