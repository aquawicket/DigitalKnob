@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::#################################################################################
::# dk_keepConsoleOpen()
::#
::#
dk_keepConsoleOpen
	call dk_debugFunc
	if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	if not defined in_subprocess (cmd /k set in_subprocess=y ^& %DKSCRIPT_PATH%) & exit ) :: keep window open
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_keepConsoleOpen
goto:eof
