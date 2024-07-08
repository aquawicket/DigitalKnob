@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::################################################################################
::# dk_getPath(path rtn_var)
::#
::#    reference: https://stackoverflow.com/a/59739663/688352
::#
:dk_getPath
	call dk_debugFunc
	if %__ARGC__% neq 2 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	set _input=%1
	set _input=%_input:"=%
	if [%_input:~-1,1%] == [\] set _input=%_input:~0,-1%
	if [%_input:~-1,1%] == [/] set _input=%_input:~0,-1%
	for %%Z in ("%_input%") do set "OUT=%%~pZ"
	endlocal & call dk_set %2 "%OUT:~0,-1%"
goto:eof



::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc

	call dk_getPath DK.cmd path
	call dk_echo "path = %path%"
goto:eof
