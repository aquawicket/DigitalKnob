@echo off
call DK.cmd

::##############################################################################
::# dk_isFunction(name) -> rtn_var
::# 
::#	Test if a string is a function name
::#
::#	@name	- The name to test
::#	@rtn_var: 	- True if the string is the name of a function, False if otherwise.
::#
::#	https://stackoverflow.com/a/85932/688352
::#
:dk_isFunction (){
	call dk_debugFunc 
	if %__ARGC__% neq 1 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	cmd /c "(help %~1 > nul || exit 0) && where %~1 > nul 2> nul"
	if %ERRORLEVEL% equ 0 (
		if defined "%~2" (endlocal & call dk_set %2 true)
        (call )
		goto:eof
	)
	
    if defined "%~2" (endlocal & call dk_set %2 false)
	(call)
goto:eof








:test_function (){
	call dk_info "..."
goto:eof

:DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	call dk_debugFunc
	
	call dk_isFunction "dk_debugFunc" && call dk_info "'dk_debugFunc' is a function" || call dk_info "'dk_debugFunc' is NOT a function"
	call dk_isFunction "NotAFunction" && call dk_info "'NotAFunction' is a function" || call dk_info "'NotAFunction' is NOT a function"
goto:eof
