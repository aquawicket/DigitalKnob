@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::####################################################################
::# dk_checkError()
::#
:dk_checkError
	call dk_debugFunc
	if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
    if %ERRORLEVEL% equ 0 goto:eof
    call dk_error "ERRORLEVEL = %ERRORLEVEL%"
goto:eof







::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_checkError
goto:eof
