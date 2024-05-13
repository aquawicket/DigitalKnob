@echo off
call DK

::####################################################################
::# dk_checkError()
::#
:dk_checkError () {
	call dk_debugFunc
	if "%*" neq "" call dk_error "%__FUNCTION__%(%*): too many arguments"
	
    if %ERRORLEVEL% equ 0 goto:eof
    call dk_error "ERRORLEVEL = %ERRORLEVEL%"
goto:eof




:DKTEST ########################################################################
