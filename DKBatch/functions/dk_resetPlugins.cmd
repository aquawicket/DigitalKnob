@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_resetPlugins()
::#
::#
:dk_resetPlugins
    call dk_debugFunc 0
 setlocal
 
    echo Resetting DKPlugins . . .

    %dk_call% dk_confirm || goto:eof
    
    cd %DKPLUGINS_DIR%
    "%GIT_EXE%" clean -f -d
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_resetPlugins
%endfunction%
