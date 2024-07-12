@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::################################################################################
::# dk_getShortPath(path rtn_var)
::#
::#
:dk_getShortPath
	call dk_debugFunc
	if %__ARGC__% neq 2 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	set _input=%1
	set _input=%_input:"=%
	if [%_input:~-1,1%] == [\] set _input=%_input:~0,-1%
	if [%_input:~-1,1%] == [/] set _input=%_input:~0,-1%
	for %%Z in ("%_input%") do set "OUT=%%~sZ"
	endlocal & call dk_set %2 "%OUT%"
goto:eof






::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc

	call dk_getShortPath "%ProgramFiles%" shortPath
	call dk_echo "shortPath = %shortPath%"
goto:eof
