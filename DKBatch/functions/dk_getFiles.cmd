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
rem # dk_getFiles("path")
rem #
rem #   reference: https://stackoverflow.com/a/138581
rem #
:dk_getFiles
%setlocal%

	set "_path_=%~1"
	%dk_call% dk_assertPath "%_path_%"

	set /a "n=0"
	for %%a in ("%_path_:/=\%\*") do (
		set "temp=%%a"
		set "dk_getFiles[!n!]=!temp:\=/!"
		set /a "n+=1"
	)

	rem ### Return the array to the calling scope ###
	set "_SCOPE_=%~n0"
	for /F "delims=" %%b in ('set dk_getFiles[') do (
		if "%_SCOPE_%" equ "%~n0" endlocal
		set "%%b"
	)
%endfunction%







rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_getFiles "C:/"
	%dk_call% dk_printVar dk_getFiles
	%dk_call% Array/dk_length dk_getFiles
	%dk_call% dk_debug "files %dk_length%"

	set "myPath=%SystemRoot:\=/%"
	%dk_call% dk_getFiles "%myPath%"
	%dk_call% dk_printVar dk_getFiles
	%dk_call% Array/dk_length dk_getFiles
	%dk_call% dk_debug "files %dk_length%"
%endfunction%
