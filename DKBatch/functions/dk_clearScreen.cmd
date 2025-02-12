@echo off
if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::################################################################################
::# dk_clearScreen()
::#
::#
:dk_clearScreen
setlocal
	%dk_call% dk_debugFunc 0
	
    cls
%endfunction%








::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_clearScreen
%endfunction%
