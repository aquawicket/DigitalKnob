@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::################################################################################
::# dk_halt()
::#
::#
:dk_halt
	call dk_debugFunc
	if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	call:HALT 2>nul
	:HALT
		call dk_echo "%red%###### HALT ######%clr%"
		()
goto:eof

::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_echo "calling dk_halt on next line"
	call dk_halt
	call dk_echo "this is the line after halt"
goto:eof
