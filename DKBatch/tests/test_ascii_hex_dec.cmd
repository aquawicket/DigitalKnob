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
::# test_ascii_hex_dec.cmd
::#
::#   reference: https://www.ascii-code.com
::#

::call dk_escapeSequences
::echo %ESC%[34m test %ESC%[0m

echo.
call dk_hexToAscii 41 ascii
echo dk_hexToAscii 41 = %ascii%
call dk_hexToAscii 00000042 ascii
echo dk_hexToAscii 00000042 = %ascii%
call dk_hexToAscii "43" ascii
echo dk_hexToAscii "43" = %ascii%

echo.
call dk_hexToDecimal 41 decimal
echo dk_hexToDecimal 41 = %decimal%
call dk_hexToDecimal 00000042 decimal
echo dk_hexToDecimal 00000042 = %decimal%
call dk_hexToDecimal "43" decimal
echo dk_hexToDecimal "43" = %decimal%


echo.
call dk_decimalToAscii 65 ascii
echo dk_decimalToAscii 65 = %ascii%
call dk_decimalToAscii 00000066 ascii
echo dk_decimalToAscii 00000066 = %ascii%
call dk_decimalToAscii "67" ascii
echo dk_decimalToAscii "67" = %ascii%

echo.
call dk_decimalToHex 65 hex
echo dk_decimalToHex 65 = %hex%
call dk_decimalToHex 00000066 hex
echo dk_decimalToHex 00000066 = %hex%
call dk_decimalToHex "67" hex
echo dk_decimalToHex "67" = %hex%


echo.
call dk_asciiToDecimal A decimal
echo dk_asciiToDecimal A = %decimal%
call dk_asciiToDecimal "B" decimal
echo dk_asciiToDecimal "B" = %decimal%

echo.
call dk_asciiToHex A hex
echo dk_asciiToHex A = %hex%
call dk_asciiToHex "B" hex
echo dk_asciiToHex "B" = %hex%

call dk_pause