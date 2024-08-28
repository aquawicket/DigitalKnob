@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::#################################################################################
:: dk_buildAll()
::
::
:dk_buildAll
 setlocal
	call dk_debugFunc 0
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0
	
	%dk_call% build_all
%endfunction%
