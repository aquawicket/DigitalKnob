@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*

::####################################################################
::# dk_refreshIcons()
::#
:dk_refreshIcons
 setlocal
    echo Refreshing windows icons

    :: for window
    ie4uinit.exe -ClearIconCache

    :: for windows 10+
    ie4uinit.exe -show
%endfunction%








::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc 0
    
    %dk_call% dk_refreshIcons
%endfunction%
