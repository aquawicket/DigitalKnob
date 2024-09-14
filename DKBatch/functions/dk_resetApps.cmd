@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_resetApps()
::#
::#
:dk_resetApps
    call dk_debugFunc 0
 setlocal
 
    echo Resetting Apps . . .

    %dk_call% dk_confirm || goto:eof
    
    cd %DKAPPS_DIR%
    "%GIT_EXE%" clean -f -d
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_resetApps
%endfunction%
