@echo off
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::####################################################################
::# dk_pullAssets()
::#
::#
:dk_pullAssets
setlocal
    %dk_call% dk_debugFunc 0
    
    %dk_call% dk_todo "dk_pullAssets"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
   
    %dk_call% dk_pullAssets
%endfunction%
