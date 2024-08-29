@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::####################################################################
::# dk_pushAssets()
::#
::#
:dk_pushAssets
 setlocal
	call dk_debugFunc 0
	
    echo not implemented,  TODO
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_pushAssets
%endfunction%
