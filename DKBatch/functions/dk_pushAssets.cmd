@echo off
if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::####################################################################
::# dk_pushAssets()
::#
::#
:dk_pushAssets
setlocal
    %dk_call% dk_debugFunc 0
    
    %dk_call% dk_todo "dk_pushAssets"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
   
    %dk_call% dk_pushAssets
%endfunction%
