@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_getNativePath(path rtn_var)
::#
::#
:dk_getNativePath
	call dk_debugFunc 2
	
	setlocal
	set _input=%1
	set _input=%_input:"=%
	if [%_input:~-1,1%] == [\] set _input=%_input:~0,-1%
	if [%_input:~-1,1%] == [/] set _input=%_input:~0,-1%
	endlocal & for %%Z in ("%_input%") do set "%2=%%~fZ"
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_set myPath "C:/Windows/System32"
	call dk_getNativePath "%myPath%" nativePath
	call dk_printVar nativePath
goto:eof
