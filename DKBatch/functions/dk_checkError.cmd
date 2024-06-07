@echo off
call DK

::####################################################################
::# dk_checkError()
::#
:dk_checkError () {
	call dk_debugFunc
	if %__ARGC__% neq 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
    if %ERRORLEVEL% equ 0 goto:eof
    call dk_error "ERRORLEVEL = %ERRORLEVEL%"
goto:eof




:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
