@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::################################################################################
::# dk_basename(path rtn_var)
::#
::#    https://en.wikipedia.org/wiki/Basename
::#
:dk_basename
	call dk_debugFunc
	if %__ARGC__% neq 2 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	setlocal enabledelayedexpansion
	set "_input_=%1"
	set "_input_=%_input_:"=%"
	if [%_input_:~-1,1%] == [\] set "_input=%_input_:~0,-1%"
	if [%_input_:~-1,1%] == [/] set "_input=%_input_:~0,-1%"
	for %%Z in ("%_input_%") do set "basename=%%~nxZ"
	endlocal & call dk_set %2 "%basename%"
goto:eof





::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_basename C:\Windows\System32\test.v123.zip name
	call dk_echo "name = %name%"
	
	call dk_basename TEST nameb
	call dk_echo "nameb = %nameb%"
goto:eof