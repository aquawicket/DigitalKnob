@echo off

::#    reference: https://www.ascii-code.com

::###### Load Function files ######
call "../functions/DK.cmd"


:: ### Hex to ->
echo.
echo dk_hexToAscii
call dk_hexToAscii 41 ascii
call dk_hexToAscii 00000042 ascii
call dk_hexToAscii "43" ascii


echo.
echo dk_hexToDecimal
call dk_hexToDecimal 41 decimal
call dk_hexToDecimal 00000042 decimal
call dk_hexToDecimal "43" decimal



:: ### Decimal to ->
echo.
echo dk_decimalToAscii
call dk_decimalToAscii 65 ascii
call dk_decimalToAscii "66" ascii



echo.
echo dk_decimalToHex
call dk_decimalToHex 65 hex
call dk_decimalToHex "66" hex





:: ### Ascii to ->
echo.
echo dk_asciiToDecimal
call dk_asciiToDecimal A decimal
call dk_asciiToDecimal "B" decimal



echo.
echo dk_asciiToHex
call dk_asciiToHex A hex
call dk_asciiToHex "B" hex




call dk_pause
