@echo off
call dk_includeGuard
call DK

::####################################################################
::# dk_asciiToHex(<ascii_string>)
::#
::#    reference: https://www.ascii-code.com
::#
:dk_asciiToHex () {
	call dk_debugFunc
	
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
	
	::echo     dk_asciiToHex %~1 = %hex%
	endlocal & set %2=%hex%
goto:eof

