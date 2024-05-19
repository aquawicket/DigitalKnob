@echo off
call DK

::####################################################################
::# dk_pullAssets()
::#
::#
:dk_pullAssets () {
	call dk_debugFunc
	if %__ARGC__% NEQ 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
    echo not implemented,  TODO
goto:eof