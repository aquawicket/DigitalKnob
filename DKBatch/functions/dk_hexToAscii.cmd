@echo OFF
::dk_includeGuard()

::####################################################################
::# dk_hexToAscii(<hex_string>)
::#
::#
:dk_hexToAscii () {
	call dk_verbose "dk_hexToAscii(%*)"
	
    setlocal enabledelayedexpansion
	set "hex=%1"
	echo !hex!> temp.hex
	call certutil -decodehex temp.hex str.txt >nul
	set /p str=<str.txt
	echo:
	( del temp.hex & del str.txt )>nul
	set "output=!str!"
	endlocal & set %2=%output%
goto:eof


