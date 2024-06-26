@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::####################################################################
::# dk_reset3rdparty()
::#
::#
:dk_reset3rdparty () {
	call dk_debugFunc
	if %__ARGC__% neq 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
    echo Resetting 3rdParty Libraries . . .
        
    call dk_confirm || goto:eof
    
    cd %DK3RDPARTY_DIR%
    "%GIT_EXE%" clean -f -d
goto:eof