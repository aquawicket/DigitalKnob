@echo off
if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::####################################################################
::# dk_resetPlugins()
::#
::#
:dk_resetPlugins
setlocal
	%dk_call% dk_debugFunc 0

    echo Resetting DKPlugins . . .

    %dk_call% dk_confirm || %return%
    
    %dk_call% dk_cd %DKPLUGINS_DIR%
    "%GIT_EXE%" -C %DKBRANCH_DIR% clean -f -d
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_resetPlugins
%endfunction%
