@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::#################################################################################
:: dk_buildAll()
::
::
:dk_buildAll
setlocal
	%dk_call% dk_debugFunc 0

	:::::::::::::::::::
 
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% build_all
%endfunction%
