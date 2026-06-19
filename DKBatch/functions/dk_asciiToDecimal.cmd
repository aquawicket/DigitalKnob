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
rem # dk_asciiToDecimal(<ascii>)
rem #
rem #	reference: https://www.ascii-code.com
rem #
:dk_asciiToDecimal
%setlocal%

	%dk_call% dk_asciiToHex %~1
	%dk_call% dk_hexToDecimal %dk_asciiToHex%
	set "dk_asciiToDecimal=%dk_hexToDecimal%"

	:return
	endlocal & (
		set "dk_asciiToDecimal_1=%~1"
		set "dk_asciiToDecimal=%dk_asciiToDecimal%"
		if "%~2" neq "" (
			set "%~2=%dk_asciiToDecimal%"
		)
	)
%endfunction%










rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_asciiToDecimal a 	& %dk_call% dk_echo "'!dk_asciiToDecimal_1!' = !dk_asciiToDecimal!"
	%dk_call% dk_asciiToDecimal b 	& %dk_call% dk_echo "'!dk_asciiToDecimal_1!' = !dk_asciiToDecimal!"
	%dk_call% dk_asciiToDecimal c 	& %dk_call% dk_echo "'!dk_asciiToDecimal_1!' = !dk_asciiToDecimal!"
	%dk_call% dk_asciiToDecimal d 	& %dk_call% dk_echo "'!dk_asciiToDecimal_1!' = !dk_asciiToDecimal!"
	%dk_call% dk_asciiToDecimal e 	& %dk_call% dk_echo "'!dk_asciiToDecimal_1!' = !dk_asciiToDecimal!"
	%dk_call% dk_asciiToDecimal f 	& %dk_call% dk_echo "'!dk_asciiToDecimal_1!' = !dk_asciiToDecimal!"
	%dk_call% dk_asciiToDecimal g 	& %dk_call% dk_echo "'!dk_asciiToDecimal_1!' = !dk_asciiToDecimal!"
%endfunction%
