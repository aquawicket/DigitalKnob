@echo off
call DK.cmd

::####################################################################
::# dk_asciiToHex(ascii, rtn_var)
::#
::#    reference: https://www.ascii-code.com
::#
:dk_asciiToHex () {
	call dk_debugFunc
	if %__ARGC__% neq 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	setlocal EnableDelayedExpansion

    :: Store the string in chr.tmp file
	set /P "=%~1" < NUL > chr.tmp

    :: Create zero.tmp file with the same number of Ascii zero characters
    for %%a in (chr.tmp) do fsutil file createnew zero.tmp %%~Za > NUL

    :: Compare both files with FC /B and get the differences
	set "hex="
	for /F "skip=1 tokens=2" %%a in ('fc /B chr.tmp zero.tmp') do set "hex=%%a"
    del chr.tmp zero.tmp
    set "hex=0x%hex:~-2%"
	
	endlocal & call dk_set %2 "%hex%"
goto:eof




:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	call dk_debugFunc
	
	call dk_set myAscii x
	call dk_asciiToHex myAscii myHex
	call dk_info "myHex = %myHex%"
goto:eof