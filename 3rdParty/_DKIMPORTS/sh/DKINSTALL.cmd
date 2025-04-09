@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=../../../DKBatch/functions/")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::####################################################################
::# DKINSTALL
::#
:DKINSTALL
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
    %dk_call% dk_cmakeEval "dk_load(%DKIMPORTS_DIR%/sh/DKINSTALL.cmake)" SH_EXE
	%dk_call% dk_assertVar SH_EXE
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	setlocal
	%dk_call% dk_debugFunc 0
	
    %dk_call% DKINSTALL
%endfunction%
