@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_getFileTime(path rtn_var)
::#
::#
:dk_getFileTime
	call dk_debugFunc 2
	
	setlocal
	set _input=%1
	set _input=%_input:"=%
	if [%_input:~-1,1%] == [\] set _input=%_input:~0,-1%
	if [%_input:~-1,1%] == [/] set _input=%_input:~0,-1%
	endlocal & for %%Z in ("%_input%") do set "%2=%%~tZ"
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_set myPath "DK.cmd"
	%dk_call% dk_getFileTime "%myPath%" fileTime
	%dk_call% dk_printVar fileTime
goto:eof
