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


rem ####################################################################
rem # dk_decimalToAscii(decimal)
rem #
rem #	reference: https://www.ascii-code.com
rem #
:dk_decimalToAscii
%setlocal%

	%dk_call% dk_decimalToHex %~1
	%dk_call% dk_hexToAscii %dk_decimalToHex%
	set dk_decimalToAscii=%dk_hexToAscii%


	:return
	endlocal & (
		set "dk_decimalToAscii_1=%~1"
		set "dk_decimalToAscii=%dk_decimalToAscii%"
		if "%~2" neq "" (
			set "%~2=%dk_decimalToAscii%"
		) else (
			rem echo %dk_decimalToAscii%
		)
	)
%endfunction%







rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	chcp 65001>nul
	for /l %%N in (200 1 255) do (
		%dk_call% dk_decimalToAscii %%N
		if "!dk_decimalToAscii_1!" neq "34" (
			rem %dk_call% dk_echo "!dk_decimalToAscii_1! = !dk_decimalToAscii!"
			echo %%N = !dk_decimalToAscii!
			endlocal
		)
	)
%endfunction%
