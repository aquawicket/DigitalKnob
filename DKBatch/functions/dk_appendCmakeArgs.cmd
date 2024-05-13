@echo off
call DK

::####################################################################
::# dk_appendCmakeArgs(<string>)
::#
::#
:dk_appendCmakeArgs () {
	call dk_debugFunc
	if "%~1" equ "" call dk_error "%__FUNCTION__%(%*): argument 1 is invalid"
	if "%~2" neq "" call dk_error "%__FUNCTION__%(%*): too many arguments"
	
    set CMAKE_ARGS=%CMAKE_ARGS% "%*"
goto:eof




:DKTEST ########################################################################
