@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_getAttributes(path rtn_var)
::#
:dk_getAttributes
	call dk_debugFunc 2
	
	setlocal
	set "_input_=%1"
	set "_input_=%_input_:"=%"
	if [%_input_:~-1,1%] == [\] set "_input_=%_input_:~0,-1%"
	if [%_input_:~-1,1%] == [/] set "_input_=%_input_:~0,-1%"
	endlocal & for %%Z in ("%_input_%") do set "%2=%%~aZ"
goto:eof







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_set myPath "DK.cmd"
	%dk_call% dk_getAttributes "%myPath%" attributes
	%dk_call% dk_printVar attributes
goto:eof
