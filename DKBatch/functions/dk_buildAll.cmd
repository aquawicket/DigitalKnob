@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::#################################################################################
:: dk_buildAll()
::
::
:dk_buildAll
    call dk_debugFunc 0
 setlocal

	:::::::::::::::::::
 
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% build_all
%endfunction%
