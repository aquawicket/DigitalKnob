@echo off
call DK

::####################################################################
::# dk_appendCmakeArgs(<string>)
::#
::#
:dk_appendCmakeArgs () {
	call dk_debugFunc
	if %__ARGC__% NEQ 1 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
    set CMAKE_ARGS=%CMAKE_ARGS% "%*"
goto:eof




:DKTEST ########################################################################
