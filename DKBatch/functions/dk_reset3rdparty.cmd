@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_reset3rdparty()
::#
::#
:dk_reset3rdparty
	call dk_debugFunc 0
	
    echo Resetting 3rdParty Libraries . . .
        
    call dk_confirm || goto:eof
    
    cd %DK3RDPARTY_DIR%
    "%GIT_EXE%" clean -f -d
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_reset3rdparty
goto:eof
