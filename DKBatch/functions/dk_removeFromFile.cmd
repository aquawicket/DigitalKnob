@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd


::##################################################################################
::# dk_removeFromFile(string file)
::#
::#
:dk_removeFromFile
	call dk_debugFunc
	if %__ARGC__% neq 2 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"

	sed -i -e "/$1/d" $2
goto:eof







::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_removeFromFile
goto:eof