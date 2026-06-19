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
rem # Array/dk_length(array)
rem #
rem #	The length data property of an Array instance represents the number of elements in that array
rem #	The value is an unsigned, 32-bit integer that is always numerically greater than the highest index in the array
rem #
rem #	REFERENCE
rem #	https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/length
rem #
:dk_length
%setlocal%

	set dk_length=0
	:length_loop
	if defined %~1[%dk_length%] (
		set /a dk_length+=1
		goto:length_loop
	)
	
	:return
	endlocal & (
		set "dk_length=%dk_length%"
		if "%~2" neq "" (
			set "%~2=%dk_length%"
		) else (
			rem echo %dk_length%
		)
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

	%dk_call% Array/dk_length myArrayA
	%dk_call% dk_debug "dk_length = %dk_length%"
%endfunction%
