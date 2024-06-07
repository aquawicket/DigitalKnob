@echo off
call DK

::#####################################################################
::# dk_getParentDir(<input> rtn_var)
::#
::#
:dk_getParentDir () {
	call dk_debugFunc
	if %__ARGC__% neq 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	setlocal enableDelayedExpansion
	for %%A in (%1.) do set "parent=%%~dpA"
    endlocal & call dk_set %2 "%parent%"
goto:eof




:DKTEST ########################################################################

	dk_getParentDir "C:\Windows\System32" parent
	echo "parent = %parent%"