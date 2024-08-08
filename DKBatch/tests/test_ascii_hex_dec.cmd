@echo off

::####################################################################
::# test_ascii_hex_dec.cmd
::#
::#   reference: https://www.ascii-code.com
::#
::###### DK_Init ######
call "../functions/DK.cmd"

call dk_escapeSequences
echo %ESC%[34m test %ESC%[0m

echo:
call dk_hexToAscii 41 ascii
echo dk_hexToAscii 41 = %ascii%
call dk_hexToAscii 00000042 ascii
echo dk_hexToAscii 00000042 = %ascii%
call dk_hexToAscii "43" ascii
echo dk_hexToAscii "43" = %ascii%

echo:
call dk_hexToDecimal 41 decimal
echo dk_hexToDecimal 41 = %decimal%
call dk_hexToDecimal 00000042 decimal
echo dk_hexToDecimal 00000042 = %decimal%
call dk_hexToDecimal "43" decimal
echo dk_hexToDecimal "43" = %decimal%


echo:
call dk_decimalToAscii 65 ascii
echo dk_decimalToAscii 65 = %ascii%
call dk_decimalToAscii 00000066 ascii
echo dk_decimalToAscii 00000066 = %ascii%
call dk_decimalToAscii "67" ascii
echo dk_decimalToAscii "67" = %ascii%

echo:
call dk_decimalToHex 65 hex
echo dk_decimalToHex 65 = %hex%
call dk_decimalToHex 00000066 hex
echo dk_decimalToHex 00000066 = %hex%
call dk_decimalToHex "67" hex
echo dk_decimalToHex "67" = %hex%


echo:
call dk_asciiToDecimal A decimal
echo dk_asciiToDecimal A = %decimal%
call dk_asciiToDecimal "B" decimal
echo dk_asciiToDecimal "B" = %decimal%

echo:
call dk_asciiToHex A hex
echo dk_asciiToHex A = %hex%
call dk_asciiToHex "B" hex
echo dk_asciiToHex "B" = %hex%

call dk_pause