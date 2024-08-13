@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_hexToVariable(name, hex)
::#
::#    reference: https://www.ascii-code.com
::#
:dk_hexToVariable
	call dk_debugFunc 2
	
	::for /f %%b in ('forfiles /c "cmd /c echo 0x1b"') do set "ESC=%%b"    ::Test:  set ESC to 0x1b

	set "hex=%~2"
	::set "hex=0x%hex:~-2%
	for /f %%b in ('forfiles /c "cmd /c echo 0x%hex:~-2%"') do set "%~1=%%b"
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0

	%dk_call% dk_hexToVariable var 0x41
	%dk_call% dk_echo "var = %var%"
goto:eof
