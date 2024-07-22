@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::################################################################################
::# dk_realpath(path, rtn_var)
::#
::#    SHELL: https://man7.org/linux/man-pages/man1/realpath.1.html
::#
:dk_realpath
	call dk_debugFunc
	if %__ARGC__% neq 2 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	setlocal
	set "_input_=%~1"
	set "_input_=%_input_:"=%"
	if [%_input_:~-1,1%] == [\] set "_input_=%_input_:~0,-1%"
	if [%_input_:~-1,1%] == [/] set "_input_=%_input_:~0,-1%"
	for %%Z in ("%_input_%") do set "_realpath_=%%~fZ"
	endlocal & set "%~2=%_realpath_%"
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_set myPath "DK.cmd"
	call dk_realpath "%myPath%" realpath
	call dk_printVar realpath
goto:eof
