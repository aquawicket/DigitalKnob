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
rem # dk_decimalToHex(decimal)
rem #
rem #	reference: https://www.ascii-code.com
rem #
:dk_decimalToHex
%setlocal%

	set /a A=%1
	set map=0123456789ABCDEF
	set H=

	:Hexloop
	set /a B=!A! %%16 & set /a A /=16 
	set H=!map:~%B%,1!!H!
	if !A! gtr 0 goto :Hexloop
	if %1 lss 16 (set H=0%H%)
	set "dk_decimalToHex=0x%H%"

	:return
	endlocal & (
		set "dk_decimalToHex_1=%~1"
		set "dk_decimalToHex=%dk_decimalToHex%"
		if "%~2" neq "" (
			set "%~2=%dk_decimalToHex%"
		) else (
			rem echo %dk_decimalToHex%
		)
	)
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	for /l %%N in (0 1 999999) do (
		%dk_call% dk_decimalToHex %%N
		%dk_call% dk_echo "!dk_decimalToHex_1! = !dk_decimalToHex!"
	)
%endfunction%
