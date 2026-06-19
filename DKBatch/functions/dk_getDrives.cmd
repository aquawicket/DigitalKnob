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
rem # dk_getDrives()
rem #
rem #   reference: https://serverfault.com/a/180824
rem #
:dk_getDrives
%setlocal%

	set /a "n=0"
	for %%i in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
		@%%i: 2>nul && set "dk_getDrives[!n!]=%%i" && set /a "n+=1"
	)

	rem ### Return the array to the calling scope ###
	set "_SCOPE_=%~n0"
	for /F "delims=" %%b in ('set dk_getDrives[ 2^>nul') do (
		if "%_SCOPE_%" equ "%~n0" endlocal
		set "%%b"
	)
%endfunction%







rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_getDrives
	
	%dk_call% Array/dk_length dk_getDrives
	%dk_call% dk_printVar dk_getDrives
	%dk_call% dk_debug "drives %dk_length%"
	
%endfunction%
