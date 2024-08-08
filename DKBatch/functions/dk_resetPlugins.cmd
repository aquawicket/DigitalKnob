@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_resetPlugins()
::#
::#
:dk_resetPlugins
	call dk_debugFunc 0
	
    echo Resetting DKPlugins . . .

    call dk_confirm || goto:eof
    
    cd %DKPLUGINS_DIR%
    "%GIT_EXE%" clean -f -d
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_resetPlugins
goto:eof
