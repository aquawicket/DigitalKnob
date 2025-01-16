@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::#################################################################################
::# dk_postBuildMenu()
::#
::#
:dk_postBuildMenu
setlocal
    %dk_call% dk_debugFunc 0
    
    %dk_call% dk_echo
    echo %target_app% %target_triple% %target_type%
        
    %dk_call% dk_echo
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
   
    %dk_call% dk_postBuildMenu
%endfunction%
