@echo off
call DK

::####################################################################
::# dk_hexToAscii(<hex_string>)
::#
::#    reference: https://www.ascii-code.com
::#
:dk_hexToAscii () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	set "hex=%~1"
	echo %hex:~-2%> hex.tmp
	
	::for /f %%b in ('forfiles /c "cmd /c echo 0x1b"') do set "ESC=%%b"
	
	call certutil -decodehex hex.tmp ascii.tmp >nul
	set "ascii="
	set /p ascii=<ascii.tmp
	( del hex.tmp & del ascii.tmp )>nul
	
	::echo dk_hexToAscii %hex% = %ascii%
	endlocal & set "%2=%ascii%"
	call dk_printVar "%2"
goto:eof