@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\..\..\DKBatch\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_installSh()
::#
:dk_installSh
	call dk_debugFunc 0
	
	%dk_call% dk_validate DKIMPORTS_DIR    "%dk_call% dk_DKIMPORTS_DIR"
    %dk_call% dk_cmakeEval "dk_load(%DKIMPORTS_DIR%/sh/DKMAKE.cmake)" "SH_EXE"
	%dk_call% dk_printVar SH_EXE
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
    %dk_call% dk_installSh
%endfunction%
