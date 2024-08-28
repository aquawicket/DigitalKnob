@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::################################################################################
::# dk_realpath(path, rtn_var)
::#
::#    SHELL: https://man7.org/linux/man-pages/man1/realpath.1.html
::#
:dk_realpath
 setlocal
	call dk_debugFunc 2
	
	set "_input_=%~1"
	set "_input_=%_input_:"=%"
	if [%_input_:~-1,1%] == [\] set "_input_=%_input_:~0,-1%"
	if [%_input_:~-1,1%] == [/] set "_input_=%_input_:~0,-1%"
	for %%Z in ("%_input_%") do set "_realpath_=%%~fZ"
	endlocal & set "%~2=%_realpath_%"
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_set myPath "DK.cmd"
	%dk_call% dk_realpath "%myPath%" realpath
	%dk_call% dk_printVar realpath
goto:eof
