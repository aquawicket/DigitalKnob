@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_getFullPath(path rtn_var)
::#
::#
:dk_getFullPath
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
	
	call dk_set myPath "DK.cmd"
	call dk_getFullPath "%myPath%" fullPath
	call dk_printVar fullPath
goto:eof
