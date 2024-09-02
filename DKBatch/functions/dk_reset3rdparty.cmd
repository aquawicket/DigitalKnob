@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::####################################################################
::# dk_reset3rdparty()
::#
::#
:dk_reset3rdparty
 setlocal
    call dk_debugFunc 0
    
    echo Resetting 3rdParty Libraries . . .
        
    %dk_call% dk_confirm || goto:eof
    
    cd %DK3RDPARTY_DIR%
    "%GIT_EXE%" clean -f -d
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc 0
    
    %dk_call% dk_reset3rdparty
goto:eof
