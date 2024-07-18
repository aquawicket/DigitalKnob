@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::################################################################################
::# dk_getExtension(path rtn_var)
::#
::#
:dk_getExtension
	call dk_debugFunc
	if %__ARGC__% neq 2 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"

	setlocal
	set "_input_=%1"
	set _input_=%_input_:"=%
	if [%_input_:~-1,1%] == [\] set _input_=%_input_:~0,-1%
	if [%_input_:~-1,1%] == [/] set _input_=%_input_:~0,-1%
	endlocal & for %%Z in ("%_input_%") do set "%2=%%~xZ"
goto:eof







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_set myPath "/test/test2/xfile.extension"
	call dk_getExtension "%myPath%" extension
	call dk_printVar extension
goto:eof