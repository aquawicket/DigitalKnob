@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_getPath(path rtn_var)
::#
::#    reference: https://stackoverflow.com/a/59739663/688352
::#
:dk_getPath
 setlocal
	call dk_debugFunc 2
	
	set "_input=%1"
	set "_input=%_input:"=%"
	if [%_input:~-1,1%] == [\] set "_input=%_input:~0,-1%"
	if [%_input:~-1,1%] == [/] set "_input=%_input:~0,-1%"
	for %%Z in ("%_input%") do set "_getPath_=%%~pZ"
	::endlocal & %dk_call% dk_set %2 "%_getPath_:~0,-1%"
	endlocal & set "%2=%_getPath_:~0,-1%"
goto:eof



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0

	%dk_call% dk_getPath DK.cmd path
	%dk_call% dk_echo "path = %path%"
goto:eof
