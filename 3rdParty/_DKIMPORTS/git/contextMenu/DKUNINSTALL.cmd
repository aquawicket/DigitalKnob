@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=../../../../DKBatch/functions/")
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::####################################################################
::# DKUNINSTALL()
::#
::#
:DKUNINSTALL
::setlocal
    %dk_call% dk_debugFunc 0
	
	%dk_call% dk_uninstallContextMenu "GIT ADD"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
	
    call :DKUNINSTALL
%endfunction%
