@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_pushAssets()
::#
::#
:dk_pushAssets
 setlocal
    %dk_call% dk_debugFunc 0
    
    echo not implemented,  TODO
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    %dk_call% dk_debugFunc 0
 setlocal
    
    %dk_call% dk_pushAssets
%endfunction%
