::dk_hexToVariable()

::################################################################################
::# dk_hexToVariable(<name> <hex>)
::#
::#
:dk_hexToVariable () {
	::call dk_verbose "dk_hexToVariable(%*)"
	
	:: Test:  set ESC to 0x1b
	for /f %%b in ('forfiles /c "cmd /c echo 0x1b"') do set "ESC=%%b"
	
	set "name=%~1"
	set "hex=%~2"
	set "hex=0x%hex:~-2%
	for /f %%b in ('forfiles /c "cmd /c echo %hex%"') do set "%name%=%%b"

goto:eof