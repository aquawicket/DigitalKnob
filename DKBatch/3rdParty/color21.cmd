@echo off

rem		######
rem		" 21 !
rem		######


:main
	call :Color A "######" \n B "" C " 21 " D "!" \n E "######" \n
	
	echo ############ foreground Colors ############
	call :Color 00 "00 = Black       "  08 "08 = Gray" \n
	call :Color 01 "01 = Blue        "  09 "09 = Light Blue" \n
	call :Color 02 "02 = Green       "  0A "0A = Light Green" \n
	call :Color 03 "03 = Aqua        "  0B "0B = Light Aqua" \n
	call :Color 04 "04 = Red         "  0C "0C = Light Red" \n
	call :Color 05 "05 = Purple      "  0D "0D = Light Purple" \n
	call :Color 06 "06 = Yellow      "  0E "0E = Light Yellow" \n
	call :Color 07 "07 = White       "  0F "0F = Bright White" \n
	echo.
	echo ############ Background Colors ############
	call :Color 00 "00 = Black       "  80 "80 = Gray" \n
	call :Color 10 "10 = Blue        "  90 "90 = Light Blue" \n
	call :Color 20 "20 = Green       "  A0 "A0 = Light Green" \n
	call :Color 30 "30 = Aqua        "  B0 "B0 = Light Aqua" \n
	call :Color 40 "40 = Red         "  C0 "C0 = Light Red" \n
	call :Color 50 "50 = Purple      "  D0 "D0 = Light Purple" \n
	call :Color 60 "60 = Yellow      "  E0 "E0 = Light Yellow" \n
	call :Color 70 "70 = White       "  F0 "F0 = Bright White" \n
	echo.

	call :Color 00 "0x00" \n
	call :Color 01 "0x01" \n
	call :Color 02 "0x02" \n
	call :Color 03 "0x03" \n
	call :Color 04 "0x04" \n
	call :Color 05 "0x05" \n
	call :Color 06 "0x06" \n
	call :Color 07 "0x07" \n
	call :Color 08 "0x08" \n
	call :Color 09 "0x09" \n
	call :Color 0A "0x0A" \n
	call :Color 0B "0x0B" \n
	call :Color 0C "0x0C" \n
	call :Color 0D "0x0D" \n
	call :Color 0E "0x0E" \n
	call :Color 0F "0x0F" \n
	
	call :Color 00 "0x00" \n
	call :Color 10 "0x10" \n
	call :Color 20 "0x20" \n
	call :Color 30 "0x30" \n
	call :Color 40 "0x40" \n
	call :Color 50 "0x50" \n
	call :Color 60 "0x60" \n
	call :Color 70 "0x70" \n
	call :Color 80 "0x80" \n
	call :Color 90 "0x90" \n
	call :Color A0 "0xA0" \n
	call :Color B0 "0xB0" \n
	call :Color C0 "0xC0" \n
	call :Color D0 "0xD0" \n
	call :Color E0 "0xE0" \n
	call :Color F0 "0xF0" \n
	
	pause
exit /B

rem #####################################################
rem # Color(hexColor text [\n])
rem #
rem #	v21
rem #	Arguments: hexColor text [\n] ...
rem #	\n -> newline ... -> repeat
rem #	Supported in windows XP, 7, 8.
rem #	In XP extended ascii characters are printed as dots.
rem #	for print quotes, use empty text.
rem #
:Color
	setlocal EnableExtensions EnableDelayedExpansion
	Subst `: "!Temp!" >nul &`: &Cd \
	setlocal DisableDelayedExpansion
	if NOT EXIST `.7 (
	echo(|(pause >nul &findstr.exe "^" >`)
	set /P "=." >>` <nul
	for /F "delims=;" %%# In (
	'"Prompt $H;&for %%_ In (_) do Rem"') do (
	set /P "=%%#%%#%%#" <nul >`.3
	set /P "=%%#%%#%%#%%#%%#" <nul >`.5
	set /P "=%%#%%#%%#%%#%%#%%#%%#" <nul >`.7))
	:__Color
		set "Text=%~2"
		if NOT DEFINED Text (set Text=^")
		setlocal EnableDelayedExpansion
		set /P "LF=" <` &set "LF=!LF:~0,1!"
		for %%# in ("!LF!") do for %%_ In (
		\ / :) do set "Text=!Text:%%_=%%~#%%_%%~#!"
		for /F delims^=^ eol^= %%# in ("!Text!") do (
		if #==#! endlocal
		if \==%%# (findstr.exe /A:%~1 . \` nul
		type `.3) else if /==%%# (findstr.exe /A:%~1 . /.\` nul
		type `.5) else (echo %%#\..\`>`.dat
		findstr.exe /F:`.dat /A:%~1 .
		type `.7))
		if "\n"=="%~3" (shift
		echo()
		shift
		shift
		if ""=="%~1" goto:eof
	goto:__Color
exit /b %errorlevel%
