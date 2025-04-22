@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


chcp 65001 >NUL
::#		Reference: https://superuser.com/a/1858992


:main
setlocal
	call :createUnicodeChar "U+20AC"
	call :createUnicodeChar "U+10437"
	call :createUnicodeChar "U+10400"
	call :createUnicodeChar "U+20AC"  U+20AC
	call :createUnicodeChar "U+10437" U+10437
	call :createUnicodeChar "U+10400" U+10400
	call :createUnicodeChar "U+1F609" smiley
	echo %U+20AC%
	echo %U+10437%
	echo %U+10400%
	echo %smiley% .. %smiley%
	pause
exit /b



:createUnicodeChar
setlocal enableDelayedExpansion
	set "code_point=%~1"
	set "code_point=!code_point:U+=!"
	set /a code_point=0x!code_point!

	if !code_point! LSS 0x10000 (
		call :dec2hex_le !code_point! utf16_le_bytes
	) else (
		set /a "code_point-=0x10000"
		set /a "W1_val=((code_point >> 10) & 0x3FF) | 0xD800"
		set /a "W2_val=(code_point & 0x3FF) | 0xDC00"
		call :dec2hex_le !W1_val! W1_hex
		call :dec2hex_le !W2_val! W2_hex
		set "utf16_le_bytes=!W1_hex! !W2_hex!"
	)

	> "!TEMP!\utf16-LE.tmp" (echo ff fe !utf16_le_bytes!)

	rem *** Decode file to binary
	> nul CertUtil -f -decodehex "!TEMP!\utf16-LE.tmp" "!TEMP!\utf16-LE.tmp"

	for /F %%C in ('type "!TEMP!\utf16-LE.tmp"') do if "%~2" == "" (
		echo(%%C
	) else (
		endlocal
		set "%~2=%%C"
	)
exit /b


:dec2hex_le
	set "hex=0123456789ABCDEF"
	set val=%1
	set "res="
	set /a "val|=0x10000"

	:dec2hex_le_loop
		set /a "nibble=val & 0x0F"
		set /a "val>>=4"
		set "res=!hex:~%nibble%,1!!res!"
	if !val! GTR 1 (goto :dec2hex_le_loop)
	
	set "%2=!res:~2,4! !res:~0,2!"
exit /b