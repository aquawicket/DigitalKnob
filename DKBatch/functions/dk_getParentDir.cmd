@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::#####################################################################
::# dk_getParentDir(<input> rtn_var)
::#
::#
:dk_getParentDir
	call dk_debugFunc
	if %__ARGC__% neq 2 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	setlocal
	for %%A in (%1.) do set "parent=%%~dpA"
    endlocal & set "%2=%parent:~0,-1%"
goto:eof






::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc

	call dk_set myPath "C:\Windows\System32"
	call dk_getParentDir "%myPath%" parent
	call dk_printVar parent
goto:eof
