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

    %dk_call% dk_confirm || %return%
    
	%dk_call% dk_validate DKAPPS_DIR "%dk_call% dk_DKBRANCH_DIR"
    %dk_call% dk_cd %DKAPPS_DIR%
    "%GIT_EXE%" -C %DKBRANCH_DIR% clean -f -d
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_resetApps
%endfunction%
