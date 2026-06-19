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
rem # dk_fileToArray(path rtn_var)
rem #
rem #  Read lines of a file into an array and echo them back
rem #
rem #  reference: https://stackoverflow.com/a/49042678
rem #
:dk_fileToArray
%setlocal%

	set "_file_=%~f1"
	set "_file_=%_file_:/=\%"
	set /a i=0
	for /F "usebackq delims=" %%a in ("%_file_%") do (
		set "%~2[!i!]=%%a"
		set /a i+=1
	)

	rem Return the array to the calling scope
	set "_SCOPE_=%~n0"
	for /F "delims=" %%a in ('set %~2[') do (
		if "%_SCOPE_%" equ "%~n0" endlocal
		set "%%a"
	)
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	rem create the file
	dir /b /a-d > array.cmd

	%dk_call% dk_fileToArray "array.cmd" MyArray

	%dk_call% dk_printVar MyArray

	rem or print items individually
	%dk_call% dk_printVar MyArray[0]
	%dk_call% dk_printVar MyArray[1]
	%dk_call% dk_printVar MyArray[2]
	%dk_call% dk_printVar MyArray[3]
	%dk_call% dk_printVar MyArray[4]
	%dk_call% dk_printVar MyArray[5]
	%dk_call% dk_printVar MyArray[6]
	%dk_call% dk_printVar MyArray[7]
%endfunction%
