@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_reset3rdparty()
::#
::#
:dk_reset3rdparty
 setlocal
    call dk_debugFunc 0
    
    echo Resetting 3rdParty Libraries . . .
        
    %dk_call% dk_confirm || %return%
    
	%dk_call% dk_validate DK3RDPARTY_DIR "%dk_call% dk_DK3RDPARTY_DIR"
    %dk_call% dk_cd %DK3RDPARTY_DIR%
    "%GIT_EXE%" -C %DKBRANCH_DIR% clean -f -d
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
    
    %dk_call% dk_reset3rdparty
%endfunction%
