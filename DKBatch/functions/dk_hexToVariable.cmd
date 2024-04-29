@echo off
call dk_includeGuard
call DK

::################################################################################
::# dk_hexToVariable(<name> <hex>)
::#
::#    reference: https://www.ascii-code.com
::#
:dk_hexToVariable () {
	call dk_debugFunc
	::for /f %%b in ('forfiles /c "cmd /c echo 0x1b"') do set "ESC=%%b"    ::Test:  set ESC to 0x1b

	set "hex=%~2"
	::set "hex=0x%hex:~-2%
	for /f %%b in ('forfiles /c "cmd /c echo 0x%hex:~-2%"') do set "%~1=%%b"
goto:eof