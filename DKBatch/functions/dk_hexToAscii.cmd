@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::####################################################################
::# dk_hexToAscii(<hex_string> rtn_var)
::#
::#    reference: https://www.ascii-code.com
::#
:dk_hexToAscii
	call dk_debugFunc
	if %__ARGC__% neq 2 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	set "hex=%~1"
	call dk_fileWrite hex.tmp %hex:~-2%
	
	::for /f %%b in ('forfiles /c "cmd /c echo 0x1b"') do set "ESC=%%b"
	
	call certutil -decodehex hex.tmp ascii.tmp >nul
	set "ascii="
	set /p ascii=<ascii.tmp
	( del hex.tmp & del ascii.tmp )>nul
	
	endlocal & call dk_set %2 "%ascii%"
goto:eof




::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
:DKTEST
	call dk_debugFunc
		
	call dk_hexToAscii 0x41 ascii
	call dk_echo "ascii = %ascii%"
goto:eof