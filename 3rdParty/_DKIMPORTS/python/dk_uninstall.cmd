@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=../../../DKBatch/functions/")
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::####################################################################
::# dk_uninstall
::#
::#
:dk_uninstall
::setlocal
    %dk_call% dk_debugFunc 0
 
	echo:
	echo ### Uninstalling Python 2.7.18 ###
	MsiExec.exe /uninstall {A5F504DF-2ED9-4A2D-A2F3-9D2750DD42D6} /quiet
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
	
    call :dk_uninstall
%endfunction%
