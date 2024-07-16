@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::#####################################################################
::# dk_getParentDir(<input> rtn_var)
::#
::#
:dk_getParentDir
	call dk_debugFunc
	if %__ARGC__% neq 2 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	setlocal enableDelayedExpansion
	for %%A in (%1.) do set "parent=%%~dpA"
    endlocal & call dk_set %2 "%parent:~0,-1%"
goto:eof






::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc

	call dk_getParentDir "C:\Windows\System32" parent
	call dk_echo "parent = %parent%"
goto:eof
