@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::####################################################################
::# dk_commandToVariable(command, rtn_var)
::#
::#    reference: https://stackoverflow.com/a/5807218
::#
:dk_commandToVariable
	call dk_debugFunc
	if %__ARGC__% neq 2 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	for /f "usebackq delims=|" %%f in (`%~1`) do (
		set "%2=%%f"
    )
goto:eof
	
	





::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_set myCommand ver
	call dk_commandToVariable "%myCommand%" myVariable
	call dk_printVar myVariable
goto:eof
